LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY battle_city_tb IS
END battle_city_tb;
 
ARCHITECTURE behavior OF battle_city_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT battle_city
    PORT(
         clk_i 			 : IN  std_logic;
         rst_n_i         : IN  std_logic;
         pixel_row_i     : IN  std_logic_vector(9 downto 0);
         pixel_col_i     : IN  std_logic_vector(9 downto 0);
         bus_addr_i      : IN  std_logic_vector(31 downto 0);
         bus_data_i      : IN  std_logic_vector(31 downto 0);
			we_i				 : IN  std_logic;
			stage_i			 : IN  unsigned(1 downto 0);
         rgb_o           : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i             : std_logic := '0';
   signal rst_n_i           : std_logic := '0';
   signal pixel_row_i       : std_logic_vector(9 downto 0)  := (others => '0');
   signal pixel_col_i       : std_logic_vector(9 downto 0)  := (others => '0');
   signal bus_addr_i        : std_logic_vector(31 downto 0) := (others => '0');
   signal bus_data_i        : std_logic_vector(31 downto 0) := (others => '0');
	signal we_i				    : std_logic;
	signal stage_i			    : unsigned(1 downto 0);

 	--Outputs
   signal rgb_o             : std_logic_vector(23 downto 0) := (others => '0');
	
	-- constants --
	constant assert_severity : severity_level := failure;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
	constant assert_sev : severity_level := failure;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: battle_city PORT MAP (
          clk_i => clk_i,
          rst_n_i => rst_n_i,
          pixel_row_i => pixel_row_i,
          pixel_col_i => pixel_col_i,
          bus_addr_i => bus_addr_i,
          bus_data_i => bus_data_i,
			 we_i => we_i,
			 stage_i => stage_i,
          rgb_o => rgb_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
	
	-- Stimulus process
   stim_proc: process begin	
		pixel_row_i <= "0000000000";
		pixel_col_i <= "0000000000";
		stage_i <= "00";
		we_i <= '0';
		wait;
	end process;
	
--	-- Test case 
--	test_proc: process begin 
--		wait for 10 ns;
--	   for I in 0 to 15 loop
--			for J in 0 to 15 loop
--			
--				-- Go trough first two row and first two columns
--				pixel_row_i <= I;
--				pixel_col_i <= J;
--				wait for clk_i_period * 10;
--				-- Insert assert here
--			end loop;
--		end loop;
--		wait;
--	end process;

END;
