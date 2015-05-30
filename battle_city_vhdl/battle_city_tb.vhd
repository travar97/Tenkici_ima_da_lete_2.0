--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:38:20 05/30/2015
-- Design Name:   
-- Module Name:   C:/Users/student/RA38-2012/battle_city_fpga/battle_city_vhdl/battle_city_tb.vhd
-- Project Name:  battle_city_vhdl
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: battle_city
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
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

 	--Outputs
   signal rgb_o             : std_logic_vector(23 downto 0) := (others => '0');
	
	-- constants --
	constant assert_severity : severity_level := failure;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: battle_city PORT MAP (
          clk_i => clk_i,
          rst_n_i => rst_n_i,
          pixel_row_i => pixel_row_i,
          pixel_col_i => pixel_col_i,
          bus_addr_i => bus_addr_i,
          bus_data_i => bus_data_i,
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
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
      wait for clk_i_period*10;
      -- insert stimulus here 

      wait;
   end process;
	
	process
   begin
      assert rgb_o =	x"10000000000000000000000000000000"
         report "Observed is asdf is expected!"
         severity assert_severity;
   end process;

END;
