
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
	generic(
		DATA_WIDTH : natural := 32;		    -- 4 byte one line of memory
		ADDR_WIDTH : natural := 13			-- 24576 bytes size of memory
	);
	port(
		i_clk    : in  std_logic;
		i_r_addr : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
		i_data   : in  std_logic_vector(DATA_WIDTH-1 downto 0);
		i_we     : in  std_logic;
		i_w_addr : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
		o_data   : out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end entity ram;

architecture arch of ram is

	type ram_t is array (0 to 2**ADDR_WIDTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
	signal mem : ram_t := (others => (others => '0'));

begin

	process(i_clk)
	begin
		if rising_edge(i_clk) then
			if i_we = '1' then
				mem(to_integer(unsigned(i_w_addr))) <= i_data;
			end if;
			o_data <= mem(to_integer(unsigned(i_r_addr)));
		end if; 
	end process;

end architecture arch;