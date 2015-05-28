----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:21:35 05/23/2015 
-- Design Name: 
-- Module Name:    memory_mux - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_mux is
	 generic(
		ADDR_WIDTH : natural := 13			-- 24576 bytes size of memory
	 );
    Port ( 
	       stage_num_sel_i     :      in  STD_LOGIC_VECTOR (1 downto 0);
           color_index_i       :      in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           static_img_texel_i  :      in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           sprite_texel_i      :      in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           matrix_index_i      :      in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           memory_index_o      :      out  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0));
end memory_mux;

architecture Behavioral of memory_mux is

begin

	with stage_num_sel_i select
		memory_index_o <=
			matrix_index_i        when "00",				 
			static_img_texel_i    when "01",
			sprite_texel_i        when "10",
			color_index_i         when others;


end Behavioral;

