--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:23:21 05/23/2015
-- Design Name:   
-- Module Name:   C:/Users/student/Documents/RA13-2012/LPRS2/Tanks/texel_sort/texel_sort_tb.vhd
-- Project Name:  texel_sort
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: texel_sort
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
 
ENTITY texel_sort_tb IS
END texel_sort_tb;
 
ARCHITECTURE behavior OF texel_sort_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT texel_sort
    PORT(
         static_img_color_index_i : IN  std_logic_vector(7 downto 0);
         static_img_z_i : IN  std_logic_vector(1 downto 0);
         sprite_color_index_i : IN  std_logic_vector(7 downto 0);
         sprite_en_i : IN  std_logic;
         sprite_z_i : IN  std_logic_vector(1 downto 0);
         color_index_o : OUT  std_logic_vector(12 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal static_img_color_index_i : std_logic_vector(7 downto 0) := (others => '0');
   signal static_img_z_i : std_logic_vector(1 downto 0) := (others => '0');
   signal sprite_color_index_i : std_logic_vector(7 downto 0) := (others => '0');
   signal sprite_en_i : std_logic := '0';
   signal sprite_z_i : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal color_index_o : std_logic_vector(12 downto 0);
	signal clk : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: texel_sort PORT MAP (
          static_img_color_index_i => static_img_color_index_i,
          static_img_z_i => static_img_z_i,
          sprite_color_index_i => sprite_color_index_i,
          sprite_en_i => sprite_en_i,
          sprite_z_i => sprite_z_i,
          color_index_o => color_index_o
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
      -- hold reset state for 100 ns;
      wait for clk_period*1;
		
		static_img_color_index_i <= x"E5";
		sprite_color_index_i <= x"0F";
		
		sprite_en_i <= '1';
		sprite_z_i <= "01";
		static_img_z_i <= "10";
		
		-- staticki --
		
		wait for clk_period*10;
		
		static_img_z_i <= "00";
		sprite_color_index_i <= x"00";
		
		-- staticki --
		
		wait for clk_period*10;
		
		static_img_z_i <= "11";
		sprite_color_index_i <= x"0F";
		static_img_color_index_i <= x"00";
		
		-- sprite --
		
		wait for clk_period*10;
		
		static_img_z_i <= "00";
		static_img_color_index_i <= x"E5";
		
		-- sprite --
		
		wait for clk_period*10;
		sprite_en_i <= '0';
		
		-- sprite -- 
		
	
      -- insert stimulus here 

      wait;
   end process;

END;
