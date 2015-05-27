--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:07:39 05/23/2015
-- Design Name:   
-- Module Name:   C:/workspace/RA58-2012/LPRS2/BeamChasing/BeamChasing/parallel_comparator_tb.vhd
-- Project Name:  BeamChasing
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: parallel_comparator
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
 
ENTITY parallel_comparator_tb IS
END parallel_comparator_tb;
 
ARCHITECTURE behavior OF parallel_comparator_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT parallel_comparator
    PORT(
         ref_row_i : IN  std_logic_vector(9 downto 0);
         ref_col_i : IN  std_logic_vector(9 downto 0);
         reg0_en_i : IN  std_logic;
         reg0_row_i : IN  std_logic_vector(9 downto 0);
         reg0_col_i : IN  std_logic_vector(9 downto 0);
         reg0_size_i : IN  std_logic;
         reg1_en_i : IN  std_logic;
         reg1_row_i : IN  std_logic_vector(9 downto 0);
         reg1_col_i : IN  std_logic_vector(9 downto 0);
         reg1_size_i : IN  std_logic;
         reg2_en_i : IN  std_logic;
         reg2_row_i : IN  std_logic_vector(9 downto 0);
         reg2_col_i : IN  std_logic_vector(9 downto 0);
         reg2_size_i : IN  std_logic;
         reg3_en_i : IN  std_logic;
         reg3_row_i : IN  std_logic_vector(9 downto 0);
         reg3_col_i : IN  std_logic_vector(9 downto 0);
         reg3_size_i : IN  std_logic;
         reg4_en_i : IN  std_logic;
         reg4_row_i : IN  std_logic_vector(9 downto 0);
         reg4_col_i : IN  std_logic_vector(9 downto 0);
         reg4_size_i : IN  std_logic;
         reg0_intersect_o : OUT  std_logic;
         reg1_intersect_o : OUT  std_logic;
         reg2_intersect_o : OUT  std_logic;
         reg3_intersect_o : OUT  std_logic;
         reg4_intersect_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ref_row_i : std_logic_vector(9 downto 0) := (others => '0');
   signal ref_col_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg0_en_i : std_logic := '0';
   signal reg0_row_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg0_col_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg0_size_i : std_logic := '0';
   signal reg1_en_i : std_logic := '0';
   signal reg1_row_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg1_col_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg1_size_i : std_logic := '0';
   signal reg2_en_i : std_logic := '0';
   signal reg2_row_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg2_col_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg2_size_i : std_logic := '0';
   signal reg3_en_i : std_logic := '0';
   signal reg3_row_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg3_col_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg3_size_i : std_logic := '0';
   signal reg4_en_i : std_logic := '0';
   signal reg4_row_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg4_col_i : std_logic_vector(9 downto 0) := (others => '0');
   signal reg4_size_i : std_logic := '0';

 	--Outputs
   signal reg0_intersect_o : std_logic;
   signal reg1_intersect_o : std_logic;
   signal reg2_intersect_o : std_logic;
   signal reg3_intersect_o : std_logic;
   signal reg4_intersect_o : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
	signal clk              : std_logic;
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: parallel_comparator PORT MAP (
          ref_row_i => ref_row_i,
          ref_col_i => ref_col_i,
          reg0_en_i => reg0_en_i,
          reg0_row_i => reg0_row_i,
          reg0_col_i => reg0_col_i,
          reg0_size_i => reg0_size_i,
          reg1_en_i => reg1_en_i,
          reg1_row_i => reg1_row_i,
          reg1_col_i => reg1_col_i,
          reg1_size_i => reg1_size_i,
          reg2_en_i => reg2_en_i,
          reg2_row_i => reg2_row_i,
          reg2_col_i => reg2_col_i,
          reg2_size_i => reg2_size_i,
          reg3_en_i => reg3_en_i,
          reg3_row_i => reg3_row_i,
          reg3_col_i => reg3_col_i,
          reg3_size_i => reg3_size_i,
          reg4_en_i => reg4_en_i,
          reg4_row_i => reg4_row_i,
          reg4_col_i => reg4_col_i,
          reg4_size_i => reg4_size_i,
          reg0_intersect_o => reg0_intersect_o,
          reg1_intersect_o => reg1_intersect_o,
          reg2_intersect_o => reg2_intersect_o,
          reg3_intersect_o => reg3_intersect_o,
          reg4_intersect_o => reg4_intersect_o
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
	   -------------------------------
		-- check pixel pushing works
		reg0_en_i <= '1';
		
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000000000";
		
		-- row pixel by pixel
		wait for clk_period*5;
		ref_row_i <= "0000000001";
		
		wait for clk_period*5;
		ref_row_i <= "0000000010";
		
		wait for clk_period*5;
		ref_row_i <= "0000000011";
		
		wait for clk_period*5;
		ref_row_i <= "0000000100";
		
		wait for clk_period*5;
		ref_row_i <= "0000000101";
		
		wait for clk_period*5;
		ref_row_i <= "0000000110";
		
		wait for clk_period*5;
		ref_row_i <= "0000000111";
		
		wait for clk_period*5;
		ref_row_i <= "0000001000";
		
		wait for clk_period*5;
		ref_row_i <= "0000001001";
		
		wait for clk_period*5;
		ref_row_i <= "0000001010";
		
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000000000";
		
		-- col pixel by pixel
		wait for clk_period*5;
		ref_col_i <= "0000000001";
		
		wait for clk_period*5;
		ref_col_i <= "0000000010";
		
		wait for clk_period*5;
		ref_col_i <= "0000000011";
		
		wait for clk_period*5;
		ref_col_i <= "0000000100";
		
		wait for clk_period*5;
		ref_col_i <= "0000000101";
		
		wait for clk_period*5;
		ref_col_i <= "0000000110";
		
		wait for clk_period*5;
		ref_col_i <= "0000000111";
		
		wait for clk_period*5;
		ref_col_i <= "0000001000";
		
		wait for clk_period*5;
		ref_col_i <= "0000001001";
		
		wait for clk_period*5;
		ref_col_i <= "0000001010";		
		
      -------------------------------
		-- check if priority is working
		
      wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000000000";
		
		reg0_en_i <= '1';
		reg1_en_i <= '1';
		reg2_en_i <= '1';
		reg3_en_i <= '1';
		reg4_en_i <= '1';
		
		wait for clk_period*5;
		reg0_en_i <= '0';
		
		wait for clk_period*5;
		reg1_en_i <= '0';
		
		wait for clk_period*5;
		reg2_en_i <= '0';
		
		wait for clk_period*5;
		reg3_en_i <= '0';
		
		wait for clk_period*5;
		reg4_en_i <= '0';
		
		--------------------------------
		-- check row performance for 8x8
		
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000000000";
		
		reg0_row_i <= "0000000000";
		reg0_col_i <= "0000000000";
		
		reg1_row_i <= "0000001000";
		reg1_col_i <= "0000000000";
		
		reg2_row_i <= "0000010000";
		reg2_col_i <= "0000000000";
		
		reg3_row_i <= "0000011000";
		reg3_col_i <= "0000000000";
		
		reg4_row_i <= "0000100000";
		reg4_col_i <= "0000000000";
		
		reg0_en_i <= '1';
		reg1_en_i <= '1';
		reg2_en_i <= '1';
		reg3_en_i <= '1';
		reg4_en_i <= '1';
		
		-- 0
		wait for clk_period*5;
		ref_row_i <= "0000001000";
		ref_col_i <= "0000000000";
		
		-- 1
		wait for clk_period*5;
		ref_row_i <= "0000010000";
		ref_col_i <= "0000000000";
		
		-- 2
		wait for clk_period*5;
		ref_row_i <= "0000011000";
		ref_col_i <= "0000000000";
		
		-- 3
		wait for clk_period*5;
		ref_row_i <= "0000100000";
		ref_col_i <= "0000000000";
		
		-- 4
		wait for clk_period*5;
		ref_row_i <= "0000101000";
		ref_col_i <= "0000000000";
		
		--------------------------------
		-- check col performance for 8x8
		
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000000000";
		
		reg0_row_i <= "0000000000";
		reg0_col_i <= "0000000000";
		
		reg1_row_i <= "0000000000";
		reg1_col_i <= "0000001000";
		
		reg2_row_i <= "0000000000";
		reg2_col_i <= "0000010000";
		
		reg3_row_i <= "0000000000";
		reg3_col_i <= "0000011000";
		
		reg4_row_i <= "0000000000";
		reg4_col_i <= "0000100000";
		
		reg0_en_i <= '1';
		reg1_en_i <= '1';
		reg2_en_i <= '1';
		reg3_en_i <= '1';
		reg4_en_i <= '1';
		
		-- 0
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000001000";
		
		-- 1
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000010000";
		
		-- 2
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000011000";
		
		-- 3
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000100000";
		
		-- 4
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000101000";
		
		--------------------------------
		-- check row performance for 16x16
		
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000000000";
		
		reg0_row_i <= "0000000000";
		reg0_col_i <= "0000000000";
		
		reg1_row_i <= "0000010000";
		reg1_col_i <= "0000000000";
		
		reg2_row_i <= "0000100000";
		reg2_col_i <= "0000000000";
		
		reg3_row_i <= "0000110000";
		reg3_col_i <= "0000000000";
		
		reg4_row_i <= "0001000000";
		reg4_col_i <= "0000000000";
		
		reg0_en_i <= '1';
		reg1_en_i <= '1';
		reg2_en_i <= '1';
		reg3_en_i <= '1';
		reg4_en_i <= '1';
		
		-- 0
		wait for clk_period*5;
		ref_row_i <= "0000010000";
		ref_col_i <= "0000000000";
		
		-- 1
		wait for clk_period*5;
		ref_row_i <= "0000100000";
		ref_col_i <= "0000000000";
		
		-- 2
		wait for clk_period*5;
		ref_row_i <= "0000110000";
		ref_col_i <= "0000000000";
		
		-- 3
		wait for clk_period*5;
		ref_row_i <= "0001000000";
		ref_col_i <= "0000000000";
		
		-- 4
		wait for clk_period*5;
		ref_row_i <= "0001010000";
		ref_col_i <= "0000000000";
		
		--------------------------------
		-- check col performance for 16x16
		
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000000000";
		
		reg0_row_i <= "0000000000";
		reg0_col_i <= "0000000000";
		
		reg1_row_i <= "0000000000";
		reg1_col_i <= "0000010000";
		
		reg2_row_i <= "0000000000";
		reg2_col_i <= "0000100000";
		
		reg3_row_i <= "0000000000";
		reg3_col_i <= "0000110000";
		
		reg4_row_i <= "0000000000";
		reg4_col_i <= "0001000000";
		
		reg0_en_i <= '1';
		reg1_en_i <= '1';
		reg2_en_i <= '1';
		reg3_en_i <= '1';
		reg4_en_i <= '1';
		
		-- 0
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000010000";
		
		-- 1
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000100000";
		
		-- 2
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0000110000";
		
		-- 3
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0001000000";
		
		-- 4
		wait for clk_period*5;
		ref_row_i <= "0000000000";
		ref_col_i <= "0001010000";
		

      wait;
   end process;

END;
