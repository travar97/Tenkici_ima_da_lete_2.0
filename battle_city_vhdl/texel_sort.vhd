----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:09 05/23/2015 
-- Design Name: 
-- Module Name:    texel_sort - Behavioral 
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity texel_sort is
	 generic(
		ADDR_WIDTH : natural := 13;		    -- 24576 bytes size of memory
		OVERHEAD   : natural := 5			-- 8 bits needed for indexing color table
	 );
    Port (
           static_img_color_index_i		     : in  STD_LOGIC_VECTOR (7 downto 0);
		   static_img_z_i                    : in  STD_LOGIC_VECTOR (1 downto 0);
           sprite_color_index_i              : in  STD_LOGIC_VECTOR (7 downto 0);
           sprite_en_i                       : in  STD_LOGIC;
           sprite_z_i                        : in  STD_LOGIC_VECTOR (1 downto 0);
           color_index_o                     : out  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0));
end texel_sort;

architecture Behavioral of texel_sort is

signal overhead_s : STD_LOGIC_VECTOR( OVERHEAD-1 downto 0 ) := ( others => '0' );

begin


	color_index_o <= overhead_s & sprite_color_index_i when 
							(
								sprite_en_i = '1' and 
								(
									-- z sort --
									( ( static_img_z_i < sprite_z_i ) and ( sprite_color_index_i > x"00" ) ) or
									-- alpha sort ( if static img index is transparent ) --
									( ( static_img_z_i > sprite_z_i ) and ( static_img_color_index_i = x"00" ) )
								)
							) else
				overhead_s & static_img_color_index_i;
	
end Behavioral;

