library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity battle_city is
	generic(
		DATA_WIDTH				: natural := 32;
		COLOR_WIDTH				: natural := 24;
		ADDR_WIDTH				: natural := 13;
		REGISTER_NUMBER		: natural := 10;
		REGISTER_OFFSET      : natural := 0;
		C_BASEADDR				: natural := 0
	);
   Port (
      clk_i    		: in  std_logic;
		rst_n_i        : in  std_logic;
		pixel_row_i    : in  std_logic_vector(9 downto 0);
		pixel_col_i    : in  std_logic_vector(9 downto 0);
		bus_addr_i     : in  std_logic_vector(31 downto 0);
		bus_data_i		: in  std_logic_vector(DATA_WIDTH-1 downto 0);
		mem_data_i   	: in  std_logic_vector(DATA_WIDTH-1 downto 0);		
		addres_o       : out std_logic_vector(ADDR_WIDTH-1 downto 0);
		rgb_o    		: out std_logic_vector(COLOR_WIDTH-1 downto 0)
   );
end battle_city;

architecture Behavioral of battle_city is

   type registers_t is array (0 to REGISTER_NUMBER-1) of unsigned (31 downto  0);


	signal registers_s		: registers_t;
	signal local_addr_s		: signed(31 to 0);	
   signal regs_gt_0			: std_logic_vector(0 to REGISTER_NUMBER-1) ;	
	signal counter_s 			: unsigned(1 downto 0);
	signal next_counter_s   : unsigned(1 downto 0);

begin

----------------------------------------
--            FIRST STAGE             --
----------------------------------------

comp_gen: for i in 0 to REGISTER_NUMBER-1 generate
	  regs_gt_0(i) <= '1' when registers_s(i) > to_unsigned(0, 32) else 
							'0';
 end generate comp_gen;

-- Write data from C --
process(clk_i) begin
	if rising_edge(clk_i) then
		if REGISTER_OFFSET <= local_addr_s and local_addr_s < REGISTER_OFFSET + REGISTER_NUMBER then
			registers_s(to_integer(local_addr_s - REGISTER_OFFSET)) <= unsigned(bus_data_i);
		end if;
	end if;
end process;

-- Stage counter --
process(clk_i) begin
	if rising_edge(clk_i) then
		if rst_n_i = '0' then
			counter_s <= "00";
		else
			counter_s <= next_counter_s;
		end if;
	end if;
end process;

-- Combinational --

next_counter_s <= "00" when counter_s = "11" else
                   counter_s + 1;
						 
local_addr_s <= signed(bus_addr_i) - C_BASEADDR;    

----------------------------------------
--            SECOND STAGE            --
----------------------------------------    

end Behavioral;