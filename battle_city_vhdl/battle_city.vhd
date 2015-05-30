library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity battle_city is
	generic(
		DATA_WIDTH				: natural := 32;		
		COLOR_WIDTH				: natural := 24;
		ADDR_WIDTH				: natural := 13;
		REGISTER_OFFSET      : natural := 0;		-- Pointer to registers in memory map
		C_BASEADDR				: natural := 0;		-- Pointer to local memory in memory map
		REGISTER_NUMBER		: natural := 10;		-- Number of registers used for sprites
		NUM_BITS_FOR_REG_NUM	: natural := 4;		-- Number of bits required for number of registers
		MAP_OFFSET				: natural := 0;		-- Pointer to start of map in memory
		OVERHEAD					: natural := 5;		-- Number of overhead bits
		SPRITE_Z					: natural := 2			-- Z coordinate of sprite
	);
   Port (
      clk_i    		: in  std_logic;
		rst_n_i        : in  std_logic;
		pixel_row_i    : in  std_logic_vector(9 downto 0);
		pixel_col_i    : in  std_logic_vector(9 downto 0);
		bus_addr_i     : in  std_logic_vector(31 downto 0);				-- Address used to point to registers
		bus_data_i		: in  std_logic_vector(DATA_WIDTH-1 downto 0);	-- Data to be writed to registers
		
		-- memory --
		--mem_data_s   	: in  std_logic_vector(DATA_WIDTH-1 downto 0);	-- Data from local memory
		--address_o      : out std_logic_vector(ADDR_WIDTH-1 downto 0);	-- Address used to read from memory
		
		-- VGA --
		rgb_o    		: out std_logic_vector(COLOR_WIDTH-1 downto 0)	-- Value of RGB color
		
		---
   );
	
	
end battle_city;

architecture Behavioral of battle_city is

	component ram 	
	port
	(
		clk_i    : in  	std_logic;
		addr_i	: in  	std_logic_vector( ADDR_WIDTH-1 downto 0 );
		data_o	: inout	std_logic_vector( DATA_WIDTH-1 downto 0 )
	);
	end component ram;

	-- Types --
   type registers_t  is array (0 to REGISTER_NUMBER-1) of unsigned (63 downto  0);
	type coordinate_t is array (0 to REGISTER_NUMBER-1) of unsigned (15 downto 0);
	type pointer_t    is array (0 to REGISTER_NUMBER-1) of unsigned (15 downto 0);
	type rotation_t   is array (0 to REGISTER_NUMBER-1) of unsigned (7 downto 0);
	type size_t       is array (0 to REGISTER_NUMBER-1) of unsigned (7 downto 0);
	
	-- Constants --
	constant size_8_c		   : unsigned (3 downto 0) := "0111";
	constant size_16_c	   : unsigned (3 downto 0) := "1111";
	constant overhead_c 	
		: std_logic_vector( OVERHEAD-1 downto 0 ) := ( others => '0' );
	

   -- Globals --
	signal registers_s		: registers_t;					-- Array representing registers
	signal counter_s 			: unsigned(1 downto 0);		-- Stage counter
	signal next_counter_s   : unsigned(1 downto 0);		-- Next stage counter
	signal thrd_stg_addr_s  : unsigned(12 downto 0);	-- Addresses needed in third stage
	signal scnd_stg_addr_s	: unsigned(12 downto 0);	-- Addresses needed in second stage
	signal frst_stg_addr_s	: unsigned(12 downto 0);	-- Addresses needed in first stage
	signal zero_stg_addr_s	: unsigned(12 downto 0);	-- Addresses needed in zero stage
	signal glb_sprite_en_s	: std_logic;					-- Global sprite enable signal
	signal reg_intersected_s: 
		unsigned(NUM_BITS_FOR_REG_NUM-1 downto 0);		-- Index of intersected sprite
	signal reg_row_s        : coordinate_t;				-- Sprite start row
	signal reg_col_s			: coordinate_t;				-- Sprite start column
	signal reg_rot_s			: rotation_t;					-- Rotation of sprite
	signal img_z_coor_s		: unsigned(7 downto 0);		-- Z coor of static img
	signal sprt_clr_ind_s	: std_logic_vector(7 downto 0);	-- Sprite color index
	signal sttc_clr_ind_s	: std_logic_vector(7 downto 0); 	-- Static color index
	signal address_s			: std_logic_vector(ADDR_WIDTH-1 downto 0);		-- memory address line 
	signal next_address_s	: std_logic_vector(ADDR_WIDTH-1 downto 0);		-- next address line in memory
	
	-- Memory --
	signal mem_data_s   	   : std_logic_vector(DATA_WIDTH-1 downto 0);	-- Data from local memory
	signal mem_address_s    : std_logic_vector(ADDR_WIDTH-1 downto 0);	-- Address used to read from memory
	
	-- Zero stage --
	signal local_addr_s		: signed(31 downto 0);	
	signal reg_size_s			: size_t;
	signal reg_en_s			: std_logic_vector(REGISTER_NUMBER-1 downto 0);
	signal reg_pointer_s    : pointer_t;
	signal reg_end_row_s		: coordinate_t;
	signal reg_end_col_s		: coordinate_t;
	signal reg_intsect_s		: std_logic_vector(REGISTER_NUMBER-1 downto 0);
	signal rel_addr_s			: unsigned(12 downto 0);
	signal result_s			: unsigned(13 downto 0);
	signal rgb_s				: std_logic_vector(COLOR_WIDTH-1 downto 0);
	
	-- First stage --
	signal frst_stg_data_s	: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal img_rot_s			: unsigned(7 downto 0);
	signal img_index_s		: unsigned(15 downto 0);
	signal offset_s   		: unsigned(7 downto 0);
	signal internal_row_s	: unsigned(3 downto 0);
	signal internal_col_s	: unsigned(3 downto 0);
	signal row_s				: unsigned(3 downto 0);
	signal col_s				: unsigned(3 downto 0);
	signal index_s 			: unsigned(15 downto 0);
	
	-- Second stage --
	signal scnd_stg_data_s	: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal max_s      		: unsigned(3 downto 0);
	signal sprt_size_s		: std_logic;
	signal read_row_s			: unsigned(15 downto 0);
	signal read_col_s			: unsigned(15 downto 0);
	signal sprt_row_s			: unsigned(3 downto 0);
	signal sprt_col_s 		: unsigned(3 downto 0);
	signal rot_s 				: unsigned(7 downto 0);
	signal s_row_s				: unsigned(3 downto 0);
	signal s_col_s				: unsigned(3 downto 0);
	signal s_offset_s   		: unsigned(7 downto 0);
	
	-- Third stage --
	signal thrd_stg_data_s	: std_logic_vector(DATA_WIDTH-1 downto 0);
	
begin
-----------------------------------------------------------------------------------
--            						    GLOBAL              									--
-----------------------------------------------------------------------------------
	process(clk_i) begin
		if rising_edge(clk_i) then
			if rst_n_i = '0' then
				counter_s <= "00";
			else
				counter_s <= next_counter_s;
				address_s <= next_address_s;
			end if;
		end if;
	end process;
	
	next_address_s <= std_logic_vector(frst_stg_addr_s) when counter_s = "00" else
							std_logic_vector(scnd_stg_addr_s) when counter_s = "01" else
							std_logic_vector(thrd_stg_addr_s) when counter_s = "10" else
							std_logic_vector(zero_stg_addr_s);
								
	-- Write data from C --
	process(clk_i) begin
		if rising_edge(clk_i) then
			if REGISTER_OFFSET <= local_addr_s and local_addr_s < REGISTER_OFFSET + REGISTER_NUMBER then
				registers_s(to_integer(local_addr_s - REGISTER_OFFSET)) <= unsigned(bus_data_i);
			end if;
		end if;
	end process;

	next_counter_s <= "00" when counter_s = "11" else
							 counter_s + 1;	
							 
	local_addr_s <= signed(bus_addr_i) - C_BASEADDR;  
	
	rgb_o <= rgb_s;
-----------------------------------------------------------------------------------
--            						ZERO  STAGE             									--
-----------------------------------------------------------------------------------

	process(counter_s, mem_data_s) begin
		if counter_s = "00" then
			rgb_s <= mem_data_s(COLOR_WIDTH-1 downto 0);
		end if;
	end process;
	
	comp_gen: for i in 0 to REGISTER_NUMBER-1 generate
		-- Slice out data from registers --
		reg_row_s(i)		<= registers_s(i)(63 downto 48);
		reg_col_s(i)		<= registers_s(i)(47 downto 32);
		reg_size_s(i)		<= '0' & registers_s(i)(30 downto 24);
		reg_en_s(i)			<= registers_s(i)(31);
		reg_rot_s(i)		<= registers_s(i)(23 downto 16);
		reg_pointer_s(i)	<= registers_s(i)(15 downto 0);
		
		-- Prepare some additional data, based on known values --
		reg_end_row_s(i) <= reg_row_s(i) + reg_size_s(i);
		reg_end_col_s(i) <= reg_col_s(i) + reg_size_s(i);
		reg_intsect_s(i) <= '1' when (unsigned(pixel_row_i) >= reg_row_s(i)      and 
												unsigned(pixel_row_i) <  reg_end_row_s(i)  and
												unsigned(pixel_col_i) >= reg_col_s(i)      and 
												unsigned(pixel_col_i) <  reg_end_col_s(i)) else
								  '0';	
	end generate comp_gen;

	reg_intersected_s <= "1001" when reg_intsect_s(9) = '1' else
								"1000" when reg_intsect_s(8) = '1' else
								"0111" when reg_intsect_s(7) = '1' else
								"0110" when reg_intsect_s(6) = '1' else
								"0101" when reg_intsect_s(5) = '1' else
								"0100" when reg_intsect_s(4) = '1' else
								"0011" when reg_intsect_s(3) = '1' else
								"0010" when reg_intsect_s(2) = '1' else
								"0001" when reg_intsect_s(1) = '1' else
								"0000" when reg_intsect_s(0) = '1' else
								"1001"; 
		
	glb_sprite_en_s <= reg_intsect_s(to_integer(reg_intersected_s));				

	result_s        <= unsigned(pixel_row_i(9 downto 3)) * 80 + unsigned(pixel_col_i(9 downto 3));
	rel_addr_s      <= result_s(12 downto 0);
	frst_stg_addr_s <= rel_addr_s + MAP_OFFSET;
-----------------------------------------------------------------------------------
--            	               FIRST STAGE             									--
-----------------------------------------------------------------------------------
	process(counter_s, mem_data_s) begin
		if counter_s = "01" then
			frst_stg_data_s <= mem_data_s;
		end if;
	end process;

	internal_row_s <= unsigned('0' & pixel_row_i(2 downto 0));
	internal_col_s <= unsigned('0' & pixel_col_i(2 downto 0));
	
	img_z_coor_s <= unsigned(frst_stg_data_s(31 downto 24));
	img_rot_s    <= unsigned(frst_stg_data_s(23 downto 16));
	index_s      <= unsigned(frst_stg_data_s(15 downto 0));
	
	col_s <= internal_col_s						when img_rot_s = "00000000" else   -- 0
	         size_8_c - internal_row_s		when img_rot_s = "00000001" else   -- 90
				size_8_c - internal_col_s  	when img_rot_s = "00000010" else   -- 180
				internal_row_s;                              			  			  -- 270

	row_s <= internal_row_s          		when img_rot_s = "00000000" else   -- 0
	         internal_col_s          		when img_rot_s = "00000001" else   -- 90
            size_8_c - internal_row_s  	when img_rot_s = "00000010" else	  -- 180
            size_8_c - internal_col_s;									 				  -- 270
	
	offset_s <= unsigned("00" & std_logic_vector(row_s(2 downto 0)) & std_logic_vector(col_s(2 downto 0)));
					
	-- NOTE: 
	-- Offset is used when we know what is exact pointer, we need to have a table of pointers to every static image. --
	-- index_s * img_size + IMG_OFFSET + offset_s  will be the pointer to memory location we really want to read.    --

	scnd_stg_addr_s <= index_s(12 downto 0) + offset_s;
-----------------------------------------------------------------------------------
--										SECOND STAGE 													--
-----------------------------------------------------------------------------------
	process(counter_s, mem_data_s) begin
		if counter_s = "10" then
			scnd_stg_data_s <= mem_data_s;			-- static image texel
		end if;
	end process;
	
	max_s      <= size_16_c when reg_size_s(to_integer(reg_intersected_s)) = 1 else
				     size_8_c;
	rot_s      <= reg_rot_s(to_integer(reg_intersected_s));		
	
	read_row_s <= reg_row_s(to_integer(reg_intersected_s)) - unsigned(pixel_row_i(2 downto 0));
	read_col_s <= reg_col_s(to_integer(reg_intersected_s)) - unsigned(pixel_col_i(2 downto 0));
	
	sprt_row_s <= read_row_s(3 downto 0);
	sprt_col_s <= read_col_s(3 downto 0);
	
	s_col_s <= sprt_col_s			when rot_s = "00000000" else	-- 0
				  max_s - sprt_row_s when rot_s = "00000001" else	-- 90
				  max_s - sprt_col_s when rot_s = "00000010" else	-- 180
				  sprt_row_s;													-- 270
				  
	s_row_s <= sprt_row_s			when rot_s = "00000000" else 	-- 0
				  sprt_col_s			when rot_s = "00000001" else  -- 90
				  max_s - sprt_row_s when rot_s = "00000010" else  -- 180
				  max_s - sprt_col_s;
				  
	s_offset_s <= s_row_s & s_col_s;
	
	-- NOTE:
	-- Similar mathematic as in first stage, should be implement here in second stage. --
	thrd_stg_addr_s <= reg_pointer_s(to_integer(reg_intersected_s))(12 downto 0) + s_offset_s;
-----------------------------------------------------------------------------------
--                            THIRD STAGE                                        --
-----------------------------------------------------------------------------------

	process(counter_s, mem_data_s) begin
		if counter_s = "11" then
			thrd_stg_data_s <= mem_data_s;	-- 
		end if;
	end process;
							
	-- calclulate color index of static image --
	with col_s(1 downto 0) select 
		sttc_clr_ind_s <= scnd_stg_data_s(31 downto 24) when "00",		
								scnd_stg_data_s(23 downto 16) when "01",
								scnd_stg_data_s(15 downto 8)  when "10",
								scnd_stg_data_s(7 downto 0)   when others;
							
	-- calclulate color index of sprite --					
	with col_s(1 downto 0) select 
		sprt_clr_ind_s <= thrd_stg_data_s(31 downto 24) when "00",
								thrd_stg_data_s(23 downto 16) when "01",
								thrd_stg_data_s(15 downto 8)  when "10",
								thrd_stg_data_s(7 downto 0)   when others;
	
	zero_stg_addr_s <=	unsigned(overhead_c & sprt_clr_ind_s) when 
								(
									glb_sprite_en_s = '1' and 
									(
										-- z sort --
										( ( img_z_coor_s < SPRITE_Z ) and ( sprt_clr_ind_s > x"00" ) ) or
										-- alpha sort ( if static img index is transparent ) --
										( ( img_z_coor_s > SPRITE_Z ) and ( sttc_clr_ind_s = x"00" ) )
									)
								) else
								unsigned(overhead_c & sttc_clr_ind_s);
								
-----------------------------------------------------------------------------------
--                            COMPMONENT INSTANCE                                --
-----------------------------------------------------------------------------------
	
	ram_i : ram
   port map(
		clk_i		=> clk_i,
		addr_i	=> address_s,
		data_o	=> mem_data_s
	);
		
	
	end Behavioral;