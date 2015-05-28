----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:41:54 05/23/2015 
-- Design Name: 
-- Module Name:    parallel_comparator - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity parallel_comparator is
    Port ( 
			  ------------------------------------------------
			  -- REFFERENCE
			  ref_row_i : in  STD_LOGIC_VECTOR (9 downto 0);
           ref_col_i : in  STD_LOGIC_VECTOR (9 downto 0);
			  ------------------------------------------------
			  -- REG0
			  reg0_en_i : in  STD_LOGIC;
           reg0_row_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg0_col_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg0_size_i : in  STD_LOGIC;
			  ------------------------------------------------
			  -- REG1
           reg1_en_i : in  STD_LOGIC;
           reg1_row_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg1_col_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg1_size_i : in  STD_LOGIC;
			  ------------------------------------------------
			  -- REG2
			  reg2_en_i : in  STD_LOGIC;
           reg2_row_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg2_col_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg2_size_i : in  STD_LOGIC;
			  ------------------------------------------------
			  -- REG3
			  reg3_en_i : in  STD_LOGIC;
           reg3_row_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg3_col_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg3_size_i : in  STD_LOGIC;
			  ------------------------------------------------
			  -- REG4
			  reg4_en_i : in  STD_LOGIC;
           reg4_row_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg4_col_i : in  STD_LOGIC_VECTOR (9 downto 0);
           reg4_size_i : in  STD_LOGIC;
			  ------------------------------------------------
			  -- OUTPUT 
			  reg0_intersect_o : out  STD_LOGIC;
           reg1_intersect_o : out  STD_LOGIC;
			  reg2_intersect_o : out  STD_LOGIC;
			  reg3_intersect_o : out  STD_LOGIC;
			  reg4_intersect_o : out  STD_LOGIC	  
			 );
end parallel_comparator;

architecture Behavioral of parallel_comparator is
	-- SIGNALS
	signal reg0_row_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg0_col_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg0_size_s:      STD_LOGIC_VECTOR(4 downto 0);
	signal reg0_inter_s:     STD_LOGIC;
	
	signal reg1_row_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg1_col_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg1_size_s:      STD_LOGIC_VECTOR(4 downto 0);
	signal reg1_inter_s:     STD_LOGIC;
	
	signal reg2_row_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg2_col_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg2_size_s:      STD_LOGIC_VECTOR(4 downto 0);
	signal reg2_inter_s:     STD_LOGIC;
	
	signal reg3_row_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg3_col_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg3_size_s:      STD_LOGIC_VECTOR(4 downto 0);
	signal reg3_inter_s:     STD_LOGIC;
	
	signal reg4_row_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg4_col_s:       STD_LOGIC_VECTOR(9 downto 0);
	signal reg4_size_s:      STD_LOGIC_VECTOR(4 downto 0);
	signal reg4_inter_s:     STD_LOGIC;

begin

	reg0_size_s <= "10000" when reg0_size_i = '1' else "01000";
	reg0_row_s <= reg0_row_i + reg0_size_s;
	reg0_col_s <= reg0_col_i + reg0_size_s;
	
	reg1_size_s <= "10000" when reg1_size_i = '1' else "01000";
	reg1_row_s <= reg1_row_i + reg1_size_s;
	reg1_col_s <= reg1_col_i + reg1_size_s;
	
	reg2_size_s <= "10000" when reg2_size_i = '1' else "01000";
	reg2_row_s <= reg2_row_i + reg2_size_s;
	reg2_col_s <= reg2_col_i + reg2_size_s;
	
	reg3_size_s <= "10000" when reg3_size_i = '1' else "01000";
	reg3_row_s <= reg3_row_i + reg3_size_s;
	reg3_col_s <= reg3_col_i + reg3_size_s;
	
	reg4_size_s <= "10000" when reg4_size_i = '1' else "01000";
	reg4_row_s <= reg4_row_i + reg4_size_s;
	reg4_col_s <= reg4_col_i + reg4_size_s;
	
	
	
	reg0_inter_s <= '1' when ((ref_row_i >= reg0_row_i and ref_row_i < reg0_row_s) and
                                (ref_col_i >= reg0_col_i and ref_col_i < reg0_col_s) and reg0_en_i = '1') else
                       '0';
	reg1_inter_s <= '1' when ((ref_row_i >= reg1_row_i and ref_row_i < reg1_row_s) and
                                (ref_col_i >= reg1_col_i and ref_col_i < reg1_col_s) and reg1_en_i = '1') else
                       '0';										  
	reg2_inter_s <= '1' when ((ref_row_i >= reg2_row_i and ref_row_i < reg2_row_s) and
                                (ref_col_i >= reg2_col_i and ref_col_i < reg2_col_s) and reg2_en_i = '1') else
                       '0';										  
	reg3_inter_s <= '1' when ((ref_row_i >= reg3_row_i and ref_row_i < reg3_row_s) and
                                (ref_col_i >= reg3_col_i and ref_col_i < reg3_col_s) and reg3_en_i = '1') else
                       '0';										  
	reg4_inter_s <= '1' when ((ref_row_i >= reg4_row_i and ref_row_i < reg4_row_s) and
                                (ref_col_i >= reg4_col_i and ref_col_i < reg4_col_s) and reg4_en_i = '1') else
                       '0';	
							  
	reg0_intersect_o <= reg0_inter_s;
	reg1_intersect_o <= '0' when reg0_inter_s = '1' else
	                    reg1_inter_s;							  
	reg2_intersect_o <= '0' when reg0_inter_s = '1' or reg1_inter_s = '1'  else
	                    reg2_inter_s;
	reg3_intersect_o <= '0' when reg0_inter_s = '1' or reg1_inter_s = '1' or reg2_inter_s = '1' else
	                    reg3_inter_s;
	reg4_intersect_o <= '0' when reg0_inter_s = '1' or reg1_inter_s = '1' or 
										  reg2_inter_s = '1' or reg3_inter_s = '1' else
	                    reg4_inter_s;  

	

end Behavioral;

