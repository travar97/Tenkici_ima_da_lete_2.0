-------------------------------------------------------------------------------
--
-- @author Milos Subotic <milos.subotic.sm@gmail.com>
-- @license MIT
--
-- @brief VGA controller.
--
-------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

library work;
	use work.vga_ctrl;

entity vga_ctrl_test is
	port(
		i_clk_24MHz  : in  std_logic;
		in_reset     : in  std_logic;
		o_leds       : out std_logic_vector(7 downto 0);

		-- To VGA.
		o_vga_clk    : out std_logic;
		o_red        : out std_logic_vector(7 downto 0);
		o_green      : out std_logic_vector(7 downto 0);
		o_blue       : out std_logic_vector(7 downto 0);
		on_blank     : out std_logic;
		on_h_sync    : out std_logic;
		on_v_sync    : out std_logic;
		on_sync      : out std_logic;
		on_pow_save  : out std_logic
	);
end entity vga_ctrl_test;

architecture arch_v1 of vga_ctrl_test is

	signal stage : unsigned(1 downto 0);
	signal px    : unsigned(9 downto 0);
	signal py    : unsigned(8 downto 0);
		
	signal red   : std_logic_vector(7 downto 0);
	signal green : std_logic_vector(7 downto 0);
	signal blue  : std_logic_vector(7 downto 0);
	
	signal clk_100MHz : std_logic;
	signal n_reset    : std_logic;
	signal cnt        : unsigned(26 downto 0);
	signal timer      : unsigned(6 downto 0);
begin

	vga: entity vga_ctrl
	port map(
		i_clk_24MHz  => i_clk_24MHz,
		in_reset     => in_reset,
		-- To GPU.
		o_clk_100MHz => clk_100MHz,
		on_reset     => n_reset,
		o_stage      => stage,
		o_pixel_x    => px,
		o_pixel_y    => py,
		i_red        => red,
		i_green      => green,
		i_blue       => blue,
		-- To VGA.
		o_vga_clk    => o_vga_clk,
		o_red        => o_red,
		o_green      => o_green,
		o_blue       => o_blue,
		on_blank     => on_blank,
		on_h_sync    => on_h_sync,
		on_v_sync    => on_v_sync,
		on_sync      => on_sync,
		on_pow_save  => on_pow_save
	);

	red   <= x"ff" when px < 320 else x"00";
	green <= x"00";
	blue  <= x"ff" when py < 240 else x"00";

	o_leds(7) <= n_reset;
	process(clk_100MHz)
	begin
		if rising_edge(clk_100MHz) then
			if n_reset = '0' then
				cnt <= (others => '0');
			else
				if cnt = 100000000-1 then						
					cnt <= (others => '0');
				else
					cnt <= cnt + 1;
				end if;
			end if;
		end if;
	end process;
	process(clk_100MHz)
	begin
		if rising_edge(clk_100MHz) then
			if n_reset = '0' then
				timer <= (others => '0');
			else
				if cnt = 100000000-1 then
					timer <= timer + 1;
				end if;
			end if;
		end if;
	end process;
	o_leds(6 downto 0) <= std_logic_vector(timer);

end architecture arch_v1;
