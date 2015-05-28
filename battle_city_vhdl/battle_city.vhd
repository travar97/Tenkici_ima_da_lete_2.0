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
		MAP_OFFSET				: natural := 0			-- Pointer to start of map in memory
	);
   Port (
      clk_i    		: in  std_logic;
		rst_n_i        : in  std_logic;
		pixel_row_i    : in  std_logic_vector(9 downto 0);
		pixel_col_i    : in  std_logic_vector(9 downto 0);
		bus_addr_i     : in  std_logic_vector(31 downto 0);				-- Address used to point to registers
		bus_data_i		: in  std_logic_vector(DATA_WIDTH-1 downto 0);	-- Data to be writed to registers
		mem_data_i   	: in  std_logic_vector(DATA_WIDTH-1 downto 0);	-- Data from local memory   		
		addres_o       : out std_logic_vector(ADDR_WIDTH-1 downto 0);	-- Address used to read from memory
		rgb_o    		: out std_logic_vector(COLOR_WIDTH-1 downto 0)	-- Value of RGB color
   );
end battle_city;

architecture Behavioral of battle_city is

   type registers_t is array (0 to REGISTER_NUMBER-1) of unsigned (63 downto  0);
	type coordinate_t is array (0 to REGISTER_NUMBER-1) of unsigned (15 downto 0);
	type pointer_t is array (0 to REGISTER_NUMBER-1) of unsigned (15 downto 0);
	type rotation_t is array (0 to REGISTER_NUMBER-1) of unsigned (7 downto 0);
	type size_t is array (0 to REGISTER_NUMBER-1) of unsigned (7 downto 0);

   -- Globals --
	signal registers_s		: registers_t;					-- Array representing registers
	signal counter_s 			: unsigned(1 downto 0);		-- Stage counter
	signal next_counter_s   : unsigned(1 downto 0);		-- Next stage counter
	signal thrd_stg_addr_s  : unsigned(12 downto 0);	-- Addresses needed in third stage
	signal scnd_stg_addr_s	: unsigned(12 downto 0);	-- Addresses needed in second stage
	signal frst_stg_addr_s	: unsigned(12 downto 0);	-- Addresses needed in first stage
	signal zero_stg_addr_s	: unsigned(12 downto 0);	-- Addresses needed in zero stage
	signal glb_sprite_en_s	: std_logic;					-- Global sprite enable signal
	
	-- Zero stage --
	signal local_addr_s		: signed(31 to 0);	
	signal reg_row_s        : coordinate_t;
	signal reg_col_s			: coordinate_t;
	signal reg_size_s			: size_t;
	signal reg_en_s			: std_logic_vector(REGISTER_NUMBER-1 downto 0);
	signal reg_rot_s			: rotation_t;
	signal reg_pointer_s    : pointer_t;
	signal reg_end_row_s		: coordinate_t;
	signal reg_end_col_s		: coordinate_t;
	signal reg_intsect_s		: std_logic_vector(REGISTER_NUMBER-1 downto 0);
	signal reg_intersected_s: unsigned(NUM_BITS_FOR_REG_NUM-1 downto 0);
	signal rel_addr_s			: unsigned(12 downto 0);
	
	-- First stage --
	signal frst_stg_data_s	: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal img_z_coor			: unsigned(7 downto 0);
	signal img_rot				: unsigned(7 downto 0);
	signal img_index			: unsigned(
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
		end if;
	end if;
end process;

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
-----------------------------------------------------------------------------------
--            						ZERO  STAGE             									--
-----------------------------------------------------------------------------------
comp_gen: for i in 0 to REGISTER_NUMBER-1 generate
	-- Slice out data from registers --
	reg_row_s(i)		<= registers_s(i)(63 downto 48);
	reg_col_s(i)		<= registers_s(i)(47 downto 32);
	reg_size_s(i)		<= '0' & registers_s(i)(30 downto 24);
	reg_en_s(i)			<= registers_s(i)(31);
	reg_rot_s(i)		<= registers_s(i)(23 downto 16);
	reg_pointer_s(i)	<= registers_s(i)(15 downto 0);
	
	-- Prepare some additional data, based on kown values --
	reg_end_row_s(i) <= reg_row_s(i) + reg_size_s(i);
	reg_end_col_s(i) <= reg_col_s(i) + reg_size_s(i);
	reg_intsect_s(i) <= '1' when (unsigned(pixel_row_i) >= reg_row_s(i) and 
											unsigned(pixel_row_i) < reg_end_row_s(i) and
											unsigned(pixel_col_i) >= reg_col_s(i) and 
											unsigned(pixel_col_i) < reg_end_col_s(i)) else
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

rel_addr_s <= unsigned(pixel_row_i(9 downto 3)) * 80 + unsigned(pixel_col_i(9 downto 3));
frst_stg_addr_s <= rel_addr_s + MAP_OFFSET;
-----------------------------------------------------------------------------------
--            						FIRST STAGE             									--
-----------------------------------------------------------------------------------
process(counter_s) begin
	if counter_s = "01" then
		frst_stg_data_s <= mem_data_i;
	end if;
end process;



scnd_stg_addr_s <= reg_pointer_s(to_integer(reg_intersected_s));
------------------------------------------------------------------------------------

end Behavioral;