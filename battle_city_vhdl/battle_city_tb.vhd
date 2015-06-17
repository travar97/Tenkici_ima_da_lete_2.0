library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	use ieee.std_logic_textio.all;
 
ENTITY battle_city_tb IS
END battle_city_tb;
 
ARCHITECTURE behavior OF battle_city_tb IS 
 
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
   constant clk_i_period : time := 10 ns;
	constant assert_sev_0 : severity_level := failure;
   constant assert_sev_1 : severity_level := failure;
   constant assert_sev_2 : severity_level := failure;
   constant assert_sev_3 : severity_level := failure;
 
	constant frm_buf_width_c  : natural := 8;
	constant frm_buf_height_c : natural := 8;
	subtype pixel_t is std_logic_vector(23 downto 0);
	type frm_buf_t is array(0 to frm_buf_height_c-1, 0 to frm_buf_width_c-1) of pixel_t;
   
	constant frm_buf_0 : frm_buf_t := (
		( x"000080", x"000080", x"000080", x"000080", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3" ),
		( x"000080", x"000080", x"000080", x"000080", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3" ),
		( x"000080", x"000080", x"000080", x"000080", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3" ),
		( x"000080", x"000080", x"000080", x"000080", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3" ),
		( x"000000", x"000000", x"000000", x"000000", x"006060", x"006060", x"006060", x"006060" ),
		( x"000000", x"000000", x"000000", x"000000", x"006060", x"006060", x"006060", x"006060" ),
		( x"000000", x"000000", x"000000", x"000000", x"006060", x"006060", x"006060", x"006060" ),
		( x"000000", x"000000", x"000000", x"000000", x"006060", x"006060", x"006060", x"006060" )
	);
   
   	constant frm_buf_1 : frm_buf_t := (
		( x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"006060", x"006060", x"006060", x"006060" ),
		( x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"006060", x"006060", x"006060", x"006060" ),
		( x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"006060", x"006060", x"006060", x"006060" ),
		( x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"006060", x"006060", x"006060", x"006060" ),
		( x"000080", x"000080", x"000080", x"000080", x"000000", x"000000", x"000000", x"000000" ),
		( x"000080", x"000080", x"000080", x"000080", x"000000", x"000000", x"000000", x"000000" ),
		( x"000080", x"000080", x"000080", x"000080", x"000000", x"000000", x"000000", x"000000" ),
		( x"000080", x"000080", x"000080", x"000080", x"000000", x"000000", x"000000", x"000000" )
	);
   
   	constant frm_buf_2 : frm_buf_t := (
		( x"006060", x"006060", x"006060", x"006060", x"000000", x"000000", x"000000", x"000000" ),
		( x"006060", x"006060", x"006060", x"006060", x"000000", x"000000", x"000000", x"000000" ),
		( x"006060", x"006060", x"006060", x"006060", x"000000", x"000000", x"000000", x"000000" ),
		( x"006060", x"006060", x"006060", x"006060", x"000000", x"000000", x"000000", x"000000" ),
		( x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"000080", x"000080", x"000080", x"000080" ),
		( x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"000080", x"000080", x"000080", x"000080" ),
		( x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"000080", x"000080", x"000080", x"000080" ),
		( x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"000080", x"000080", x"000080", x"000080" )
	);
   
   	constant frm_buf_3 : frm_buf_t := (
		( x"000000", x"000000", x"000000", x"000000", x"000080", x"000080", x"000080", x"000080" ),
		( x"000000", x"000000", x"000000", x"000000", x"000080", x"000080", x"000080", x"000080" ),
		( x"000000", x"000000", x"000000", x"000000", x"000080", x"000080", x"000080", x"000080" ),
		( x"000000", x"000000", x"000000", x"000000", x"000080", x"000080", x"000080", x"000080" ),
		( x"006060", x"006060", x"006060", x"006060", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3" ),
		( x"006060", x"006060", x"006060", x"006060", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3" ),
		( x"006060", x"006060", x"006060", x"006060", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3" ),
		( x"006060", x"006060", x"006060", x"006060", x"c3c3c3", x"c3c3c3", x"c3c3c3", x"c3c3c3" )
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
	
	-- Test case for element rotation
	test_proc_0: process begin 
	
		-- Reset for 4 clocks
      rst_n_i <= '0';
	 	wait for 5 ns;
		
	   stage_i <= "00";
	   we_i <= '0';
      pixel_row_i <= "000000000";   -- 0
      pixel_col_i <= "0000000000";  -- 0
		
		wait for clk_i_period * 4;
		rst_n_i <= '1';
		wait for clk_i_period;
				
		-- Go trough first row and compare to unrotated element
      for element in 0 to 79 loop
         for r in 0 to frm_buf_height_c-1 loop
            pixel_row_i <= to_unsigned(r, 9);
            
            for c in 0 to frm_buf_width_c-1 loop
               pixel_col_i <= to_unsigned(c+(8*element), 10);
               
               stage_i <= "01";
               
               wait for clk_i_period;
               stage_i <= "10";
               
               wait for clk_i_period;
               stage_i <= "11";
               
               wait for clk_i_period;
               stage_i <= "00";
               
               wait for clk_i_period/2;
--               assert rgb_o = frm_buf_0(r, c)
--                  report "TEST_0: On r = " & natural'image(r) & " c = " & natural'image(c+(8*element)) & ":" & LF 
--                  severity assert_sev_0;
               wait for clk_i_period/2;
               
            end loop;
         end loop;
      end loop;
      
      wait;
   end process;
   
--   test_proc_1: process begin
--      -- Reset for 4 clocks
--      rst_n_i <= '0';
--		wait for 5 ns;
--		
--		stage_i <= "00";
--		we_i <= '0';
--      pixel_row_i <= "000001000";   -- 8 
--      pixel_col_i <= "0000000000";  -- 0
--		
--		wait for clk_i_period * 4;
--		rst_n_i <= '1';
--		wait for clk_i_period;
--      
--      -- Go trough second row and compare with element rotated by 90 degrees.
--      for element in 0 to 79 loop
--         for r in 0 to frm_buf_height_c-1 loop
--            pixel_row_i <= to_unsigned((r+8), 9);
--            
--            for c in 0 to frm_buf_width_c-1 loop
--               pixel_col_i <= to_unsigned(c+(8*element), 10);
--               
--               stage_i <= "01";
--               
--               wait for clk_i_period;
--               stage_i <= "10";
--               
--               wait for clk_i_period;
--               stage_i <= "11";
--               
--               wait for clk_i_period;
--               stage_i <= "00";
--               
--               wait for clk_i_period/2;
--               assert rgb_o = frm_buf_1(r, c)
--                  report "TEST_1: On r = " & natural'image(r+8) & " c = " & natural'image(c+(8*element)) & ":" & LF 
--                  severity assert_sev_1;
--               wait for clk_i_period/2;
--               
--            end loop;
--         end loop;
--      end loop;
--      
--      wait;
--   end process;
      
--   test_proc_2: process begin
--      -- Reset for 4 clocks
--      rst_n_i <= '0';
--		wait for 5 ns;
--		
--		stage_i <= "00";
--		we_i <= '0';
--      pixel_row_i <= "000010000";   -- 16 
--      pixel_col_i <= "0000000000";  -- 0
--		
--		wait for clk_i_period * 4;
--		rst_n_i <= '1';
--		wait for clk_i_period;
--      
--      -- Go trough third row and compare with element rotated by 180 degrees.
--      for element in 0 to 79 loop
--         for r in 0 to frm_buf_height_c-1 loop
--            pixel_row_i <= to_unsigned((r+16), 9);
--            
--            for c in 0 to frm_buf_width_c-1 loop
--               pixel_col_i <= to_unsigned(c+(8*element), 10);
--               
--               stage_i <= "01";
--               
--               wait for clk_i_period;
--               stage_i <= "10";
--               
--               wait for clk_i_period;
--               stage_i <= "11";
--               
--               wait for clk_i_period;
--               stage_i <= "00";
--               
--               wait for clk_i_period/2;
--               assert rgb_o = frm_buf_2(r, c)
--                  report "TEST_2: On r = " & natural'image(r+16) & " c = " & natural'image(c+(8*element)) & ":" & LF 
--                  severity assert_sev_2;
--               wait for clk_i_period/2;
--               
--            end loop;
--         end loop;
--      end loop;
--      
--      wait;
--   end process;

--   test_proc_3: process begin
--      -- Reset for 4 clocks
--      rst_n_i <= '0';
--		wait for 5 ns;
--		
--		stage_i <= "00";
--		we_i <= '0';
--      pixel_row_i <= "000011000";   -- 24 
--      pixel_col_i <= "0000000000";  -- 0
--		
--		wait for clk_i_period * 4;
--		rst_n_i <= '1';
--		wait for clk_i_period;
--      
--      -- Go trough fourth row and compare with element rotated by 270 degrees.
--      for element in 0 to 79 loop
--         for r in 0 to frm_buf_height_c-1 loop
--            pixel_row_i <= to_unsigned((r+24), 9);
--            
--            for c in 0 to frm_buf_width_c-1 loop
--               pixel_col_i <= to_unsigned(c+(8*element), 10);
--               
--               stage_i <= "01";
--               
--               wait for clk_i_period;
--               stage_i <= "10";
--               
--               wait for clk_i_period;
--               stage_i <= "11";
--               
--               wait for clk_i_period;
--               stage_i <= "00";
--               
--               wait for clk_i_period/2;
--               assert rgb_o = frm_buf_3(r, c)
--                  report "TEST_3: On r = " & natural'image(r+24) & " c = " & natural'image(c+(8*element)) & ":" & LF 
--                  severity assert_sev_3;
--               wait for clk_i_period/2;
--               
--            end loop;
--         end loop;
--      end loop;
--      
--      wait;
--   end process;

END;
