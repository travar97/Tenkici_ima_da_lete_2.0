library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	use ieee.std_logic_textio.all;
 
ENTITY battle_city_tb IS
END battle_city_tb;
 
ARCHITECTURE behavior OF battle_city_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT battle_city
    PORT(
         clk_i 			 : IN  std_logic;
         rst_n_i         : IN  std_logic;
         pixel_row_i     : IN  unsigned(8 downto 0);
         pixel_col_i     : IN  unsigned(9 downto 0);
         bus_addr_i      : IN  std_logic_vector(31 downto 0);
         bus_data_i      : IN  std_logic_vector(31 downto 0);
			we_i				 : IN  std_logic;
			stage_i			 : IN  unsigned(1 downto 0);
         rgb_o           : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal clk_i             : std_logic := '0';
   signal rst_n_i           : std_logic := '0';
   signal pixel_row_i       : unsigned(8 downto 0)  := (others => '0');
   signal pixel_col_i       : unsigned(9 downto 0)  := (others => '0');
   signal bus_addr_i        : std_logic_vector(31 downto 0) := (others => '0');
   signal bus_data_i        : std_logic_vector(31 downto 0) := (others => '0');
	signal we_i				    : std_logic;
	signal stage_i			    : unsigned(1 downto 0);

 	--Outputs
   signal rgb_o             : std_logic_vector(23 downto 0) := (others => '0');
	
	-- constants --
	constant assert_severity : severity_level := failure;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
	constant assert_sev : severity_level := failure;
 
	constant frm_buf_width_c  : natural := 8;
	constant frm_buf_height_c : natural := 8;
	subtype pixel_t is std_logic_vector(23 downto 0);
	type frm_buf_t is array(0 to frm_buf_height_c-1, 0 to frm_buf_width_c-1) of pixel_t;
	constant frm_buf : frm_buf_t := (
		( x"0000ff", x"ff0000", x"00ff00", x"ff00ff", x"0000ff", x"ff0000", x"00ff00", x"ff00ff" ),
		( x"0000ff", x"ff0000", x"00ff00", x"ff00ff", x"0000ff", x"ff0000", x"00ff00", x"ff00ff" ),
		( x"0000ff", x"ff0000", x"00ff00", x"ff00ff", x"0000ff", x"ff0000", x"00ff00", x"ff00ff" ),
		( x"0000ff", x"ff0000", x"00ff00", x"ff00ff", x"0000ff", x"ff0000", x"00ff00", x"ff00ff" ),
		( x"ff00ff", x"ff00ff", x"ff00ff", x"ff00ff", x"00ff00", x"00ff00", x"00ff00", x"00ff00" ),
		( x"ff00ff", x"ff00ff", x"ff00ff", x"ff00ff", x"00ff00", x"00ff00", x"00ff00", x"00ff00" ),
		( x"ff00ff", x"ff00ff", x"ff00ff", x"ff00ff", x"00ff00", x"00ff00", x"00ff00", x"00ff00" ),
		( x"ff00ff", x"ff00ff", x"ff00ff", x"ff00ff", x"00ff00", x"00ff00", x"00ff00", x"00ff00" )
		

	);
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: battle_city PORT MAP (
          clk_i => clk_i,
          rst_n_i => rst_n_i,
          pixel_row_i => pixel_row_i,
          pixel_col_i => pixel_col_i,
          bus_addr_i => bus_addr_i,
          bus_data_i => bus_data_i,
			 we_i => we_i,
			 stage_i => stage_i,
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
	
--	-- Stimulus process
--   stim_proc: process begin	
--		-- Reset for 4 clocks
--		wait for 5 ns;
--		
--		wait for clk_i_period *4;
--		rst_n_i <= '1';
--		
--		wait for clk_i_period;
--		pixel_row_i <= "0000000000";
--		pixel_col_i <= "0000000000";
--		stage_i <= "00";
--		we_i <= '0';
--		
--		wait for clk_i_period;
--		stage_i <= "01";
--		
--		wait for clk_i_period;
--		stage_i <= "10";
--		
--		wait for clk_i_period;
--		stage_i <= "11";
--		
--		wait for clk_i_period;
--		stage_i <= "00";
--		
--		wait for clk_i_period * 8;
--		pixel_row_i <= "0000001000";
--		pixel_col_i <= "0000001000";
--	end process;
	
	
	-- Test case 
	test_proc: process begin 
	
		-- Reset for 4 clocks
		wait for 5 ns;
		
		stage_i <= "00";
		we_i <= '0';
		
		wait for clk_i_period * 4;
		rst_n_i <= '1';
		wait for clk_i_period;
				
		-- Go trough first two row and first two columns
		for r in 0 to frm_buf_height_c-1 loop
			pixel_row_i <= to_unsigned(r, 9);
			
			for c in 0 to frm_buf_width_c-1 loop
				pixel_col_i <= to_unsigned(c, 10);
				

				stage_i <= "01";
				
				wait for clk_i_period;
				stage_i <= "10";
				
				wait for clk_i_period;
				stage_i <= "11";
				
				wait for clk_i_period;
				stage_i <= "00";
				
				wait for clk_i_period/2;
				-- Assert here
				assert rgb_o = frm_buf(r, c)
					report "On r = " & natural'image(r) & " c = " & natural'image(c) & ":" & LF --&
						--"expected pixel = " & natural'image(to_integer(frm_buf(r, c))) & LF &
						--"observed pixel = " & integer'image(to_integer(rgb_o))
					severity assert_severity;
				wait for clk_i_period/2;
			end loop;
		end loop;
			
		wait;
	end process;

END;
