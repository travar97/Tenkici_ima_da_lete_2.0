
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity battle_city_top is
	Port
	(
		clk_24MHz_i		: in  std_logic;
		rst_in			: in  std_logic;
		
		vga_clk_o		: out std_logic;
		red_o				: out std_logic_vector(7 downto 0);
		green_o			: out std_logic_vector(7 downto 0);
		blue_o			: out std_logic_vector(7 downto 0);
		blank_on			: out std_logic;
		h_sync_on		: out std_logic;
		v_sync_on		: out std_logic;
		sync_on			: out std_logic;
		pow_save_on		: out std_logic
	);
end battle_city_top;

architecture Behavioral of battle_city_top is

	component vga_ctrl is
		port(
			i_clk_24MHz  : in  std_logic;
			in_reset     : in  std_logic;
			-- To GPU.
			o_clk_100MHz : out std_logic;
			on_reset     : out std_logic;
			o_stage      : out unsigned(1 downto 0);
			o_pixel_x    : out unsigned(9 downto 0);
			o_pixel_y    : out unsigned(8 downto 0);
			i_red        : in  std_logic_vector(7 downto 0);
			i_green      : in  std_logic_vector(7 downto 0);
			i_blue       : in  std_logic_vector(7 downto 0);
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
	end component vga_ctrl;
	
	component battle_city is
		generic(
			DATA_WIDTH				: natural := 32;		
			COLOR_WIDTH				: natural := 24;
			ADDR_WIDTH				: natural := 13;
			REGISTER_OFFSET      : natural := 0;		-- Pointer to registers in memory map
			C_BASEADDR				: natural := 0;		-- Pointer to local memory in memory map
			REGISTER_NUMBER		: natural := 10;		-- Number of registers used for sprites
			NUM_BITS_FOR_REG_NUM	: natural := 4;		-- Number of bits required for number of registers
			MAP_OFFSET				: natural := 0;		-- Pointer to start of map in memory
			OVERHEAD					: natural := 5;		-- Number of overhead bits
			SPRITE_Z					: natural := 2			-- Z coordinate of sprite
		);
		Port (
			clk_i    		: in  std_logic;
			rst_n_i        : in  std_logic;
			pixel_row_i    : in  std_logic_vector(9 downto 0);
			pixel_col_i    : in  std_logic_vector(9 downto 0);
			bus_addr_i     : in  std_logic_vector(31 downto 0);				-- Address used to point to registers
			bus_data_i		: in  std_logic_vector(DATA_WIDTH-1 downto 0);	-- Data to be writed to registers
			we_i				: in  std_logic;
			stage_i			: in  unsigned(1 downto 0);
			-- memory --
			--mem_data_s   	: in  std_logic_vector(DATA_WIDTH-1 downto 0);	-- Data from local memory
			--address_o      : out std_logic_vector(ADDR_WIDTH-1 downto 0);	-- Address used to read from memory
			
			-- VGA --
			rgb_o    		: out std_logic_vector(COLOR_WIDTH-1 downto 0)	-- Value of RGB color
			
			---
		);
		
		
	end component battle_city;
	
	signal clk_100MHz_s	: std_logic;
	signal reset_sn		: std_logic;
	signal rgb_s			: std_logic_vector(23 downto 0);
	signal pixel_x_s		: unsigned(9 downto 0);
	signal pixel_y_s		: unsigned(8 downto 0);
	signal stage_s			: unsigned(1 downto 0);

begin

	vga_ctrl_i : vga_ctrl
	port map
	(
		i_clk_24MHz		=> clk_24MHz_i,
		in_reset			=> rst_in,
		
		o_clk_100MHz	=> clk_100MHz_s,
		on_reset			=>	reset_sn,
		o_stage			=> stage_s,
		o_pixel_x		=> pixel_x_s,
		o_pixel_y		=> pixel_y_s,
		i_red				=> rgb_s(23 downto 16),
		i_green			=> rgb_s(15 downto 8),
		i_blue			=> rgb_s(7 downto 0),

		o_vga_clk		=> vga_clk_o,
		o_red				=> red_o,
		o_green			=> green_o,
		o_blue			=> blue_o,
		on_blank			=> blank_on,
		on_h_sync		=> h_sync_on,
		on_v_sync		=> v_sync_on,
		on_sync			=> sync_on,
		on_pow_save		=> pow_save_on
	);
	
	battle_city_i : battle_city
	port map
	(
		clk_i				=> clk_100MHz_s,
		rst_n_i			=> reset_sn,
		pixel_row_i		=> "0" & std_logic_vector(pixel_y_s),
		pixel_col_i		=> std_logic_vector(pixel_x_s),
		bus_addr_i		=> (others => '0'),
		bus_data_i		=> (others => '0'),
		we_i				=> '0',
		stage_i			=> stage_s,

		rgb_o				=> rgb_s
	);

end Behavioral;

