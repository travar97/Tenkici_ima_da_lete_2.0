--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:05:41 05/23/2015
-- Design Name:   
-- Module Name:   C:/workspace/RA58-2012/LPRS2/BeamChasing/BeamChasing/calculate_and_rotate_tb.vhd
-- Project Name:  BeamChasing
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: calculate_and_rotate
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
--USE ieee.numeric_std.ALL;
 
ENTITY calculate_and_rotate_tb IS
END calculate_and_rotate_tb;
 
ARCHITECTURE behavior OF calculate_and_rotate_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT calculate_and_rotate
    PORT(
         pointer_i : IN  std_logic_vector(12 downto 0);
         row_i : IN  std_logic_vector(3 downto 0);
         col_i : IN  std_logic_vector(3 downto 0);
         rot_i : IN  std_logic_vector(1 downto 0);
         size_i : IN  std_logic;
         pointer_o : OUT  std_logic_vector(12 downto 0);
         select_o : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal pointer_i : std_logic_vector(12 downto 0) := (others => '0');
   signal row_i : std_logic_vector(3 downto 0) := (others => '0');
   signal col_i : std_logic_vector(3 downto 0) := (others => '0');
   signal rot_i : std_logic_vector(1 downto 0) := (others => '0');
   signal size_i : std_logic := '0';

 	--Outputs
   signal pointer_o : std_logic_vector(12 downto 0);
   signal select_o : std_logic_vector(1 downto 0);
	signal clk      : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: calculate_and_rotate PORT MAP (
          pointer_i => pointer_i,
          row_i => row_i,
          col_i => col_i,
          rot_i => rot_i,
          size_i => size_i,
          pointer_o => pointer_o,
          select_o => select_o
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
	   -------------------------
		-- SIZE 8x8 
	   -------------------------
	   -- edges without rotating
      wait for clk_period*10;
		row_i <= "0000";
		col_i <= "0000";
		size_i <= '0';
		rot_i <= "00";
		pointer_i <= "0000000000000";
		
		wait for clk_period*10;
		row_i <= "0111";
		
		wait for clk_period*10;
		col_i <= "0111";
		
		wait for clk_period*10;
		row_i <= "0000";
		
		-- center without rotating
		wait for clk_period*10;
		row_i <= "0011";
		col_i <= "0011";
		
		wait for clk_period*10;
		row_i <= "0100";
		col_i <= "0100";
		-------------------------
		-- edges with rotating 90
		wait for clk_period*10;
		row_i <= "0000";
		col_i <= "0000";
		rot_i <= "01";
		
		wait for clk_period*10;
		row_i <= "0111";
		
		wait for clk_period*10;
		col_i <= "0111";
		
		wait for clk_period*10;
		row_i <= "0000";
		
		-- center with rotating 90
		wait for clk_period*10;
		row_i <= "0011";
		col_i <= "0011";
		
		wait for clk_period*10;
		row_i <= "0100";
		col_i <= "0100";
		--------------------------
		-- edges with rotating 180
		wait for clk_period*10;
		row_i <= "0000";
		col_i <= "0000";
		rot_i <= "10";
		
		wait for clk_period*10;
		row_i <= "0111";
		
		wait for clk_period*10;
		col_i <= "0111";
		
		wait for clk_period*10;
		row_i <= "0000";
		
		-- center with rotating 180
		wait for clk_period*10;
		row_i <= "0011";
		col_i <= "0011";
		
		wait for clk_period*10;
		row_i <= "0100";
		col_i <= "0100";
		--------------------------
		-- edges with rotating 270
		wait for clk_period*10;
		row_i <= "0000";
		col_i <= "0000";
		rot_i <= "11";
		
		wait for clk_period*10;
		row_i <= "0111";
		
		wait for clk_period*10;
		col_i <= "0111";
		
		wait for clk_period*10;
		row_i <= "0000";
		
		-- center with rotating 270
		wait for clk_period*10;
		row_i <= "0011";
		col_i <= "0011";
		
		wait for clk_period*10;
		row_i <= "0100";
		col_i <= "0100";
		
		-------------------------
		-- SIZE 16x16 
	   -------------------------
	   -- edges without rotating
      wait for clk_period*10;
		row_i <= "0000";
		col_i <= "0000";
		size_i <= '1';
		rot_i <= "00";
		pointer_i <= "0000000000000";
		
		wait for clk_period*10;
		row_i <= "1111";
		
		wait for clk_period*10;
		col_i <= "1111";
		
		wait for clk_period*10;
		row_i <= "0000";
		
		-- center without rotating
		wait for clk_period*10;
		row_i <= "0111";
		col_i <= "0111";
		
		wait for clk_period*10;
		row_i <= "1000";
		col_i <= "1000";
		-------------------------
		-- edges with rotating 90
		wait for clk_period*10;
		row_i <= "0000";
		col_i <= "0000";
		rot_i <= "01";
		
		wait for clk_period*10;
		row_i <= "1111";
		
		wait for clk_period*10;
		col_i <= "1111";
		
		wait for clk_period*10;
		row_i <= "0000";
		
		-- center with rotating 90
		wait for clk_period*10;
		row_i <= "0111";
		col_i <= "0111";
		
		wait for clk_period*10;
		row_i <= "1000";
		col_i <= "1000";
		--------------------------
		-- edges with rotating 180
		wait for clk_period*10;
		row_i <= "0000";
		col_i <= "0000";
		rot_i <= "10";
		
		wait for clk_period*10;
		row_i <= "1111";
		
		wait for clk_period*10;
		col_i <= "1111";
		
		wait for clk_period*10;
		row_i <= "0000";
		
		-- center with rotating 180
		wait for clk_period*10;
		row_i <= "0111";
		col_i <= "0111";
		
		wait for clk_period*10;
		row_i <= "1000";
		col_i <= "1000";
		--------------------------
		-- edges with rotating 270
		wait for clk_period*10;
		row_i <= "0000";
		col_i <= "0000";
		rot_i <= "11";
		
		wait for clk_period*10;
		row_i <= "1111";
		
		wait for clk_period*10;
		col_i <= "1111";
		
		wait for clk_period*10;
		row_i <= "0000";
		
		-- center with rotating 270
		wait for clk_period*10;
		row_i <= "0111";
		col_i <= "0111";
		
		wait for clk_period*10;
		row_i <= "1000";
		col_i <= "1000";		


      wait;
   end process;

END;
