----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:12:59 05/23/2015 
-- Design Name: 
-- Module Name:    calculate_and_rotate - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity calculate_and_rotate is
    Port ( 
	      -- INPUT 
			pointer_i : in  STD_LOGIC_VECTOR (12 downto 0);
         row_i     : in  STD_LOGIC_VECTOR (3 downto 0);
         col_i     : in  STD_LOGIC_VECTOR (3 downto 0);
         rot_i     : in  STD_LOGIC_VECTOR (1 downto 0);
			size_i    : in  STD_LOGIC;
			-- OUTPUT
         pointer_o : out STD_LOGIC_VECTOR (12 downto 0);
			select_o  : out STD_LOGIC_VECTOR (1 downto 0)
			);
end calculate_and_rotate;

architecture Behavioral of calculate_and_rotate is
	-- SIGNALS
	signal offset_s   : STD_LOGIC_VECTOR (7 downto 0);
	signal org_row_s  : STD_LOGIC_VECTOR (4 downto 0);
	signal org_col_s  : STD_LOGIC_VECTOR (4 downto 0);
	signal row_s 	   : STD_LOGIC_VECTOR (4 downto 0);
	signal col_s      : STD_LOGIC_VECTOR (4 downto 0);
	signal max_s      : STD_LOGIC_VECTOR (4 downto 0);
	signal test_s     : STD_LOGIC_VECTOR (4 downto 0);
	
	-- CONSTANTS
	constant size_8   : STD_LOGIC_VECTOR (4 downto 0) := "00111";
	constant size_16  : STD_LOGIC_VECTOR (4 downto 0) := "01111";

begin
	max_s <= size_16 when size_i = '1' else
            size_8;	
				
	org_row_s <= '0' & row_i;
	org_col_s <= '0' & col_i;
	
	test_s <= max_s - org_row_s;
	
	col_s <= org_col_s          when rot_i = "00" else -- 0
	         max_s - org_row_s  when rot_i = "01" else -- 90
				max_s - org_col_s  when rot_i = "10" else -- 180
				org_row_s;                                -- 270

	row_s <= org_row_s          when rot_i = "00" else -- 0
	         org_col_s          when rot_i = "01" else -- 90
            max_s - org_row_s  when rot_i = "10" else -- 180
            max_s - org_col_s;  				            -- 270
	
	offset_s <= "00" & row_s(2 downto 0) & col_s(2 downto 0) when size_i = '0'  else
	            row_s(3 downto 0) & col_s(3 downto 0);
					
	pointer_o <= pointer_i + offset_s(7 downto 2);
   select_o <= offset_s(1 downto 0);
	
end Behavioral;

