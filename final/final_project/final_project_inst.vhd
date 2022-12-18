	component final_project is
		port (
			accumulate_wire_export         : in    std_logic                     := 'X';             -- export
			clk_clk                        : in    std_logic                     := 'X';             -- clk
			grid_pio0_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio1_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio10_export              : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio11_export              : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio12_export              : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio13_export              : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio14_export              : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio15_export              : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio2_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio3_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio4_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio5_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio6_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio7_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio8_export               : out   std_logic_vector(15 downto 0);                    -- export
			grid_pio9_export               : out   std_logic_vector(15 downto 0);                    -- export
			hex_digits_export              : out   std_logic_vector(15 downto 0);                    -- export
			key_external_connection_export : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			keycode_export                 : out   std_logic_vector(7 downto 0);                     -- export
			leds_export                    : out   std_logic_vector(13 downto 0);                    -- export
			reset_reset_n                  : in    std_logic                     := 'X';             -- reset_n
			sdram_clk_clk                  : out   std_logic;                                        -- clk
			sdram_wire_addr                : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba                  : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n               : out   std_logic;                                        -- cas_n
			sdram_wire_cke                 : out   std_logic;                                        -- cke
			sdram_wire_cs_n                : out   std_logic;                                        -- cs_n
			sdram_wire_dq                  : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                 : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n               : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                : out   std_logic;                                        -- we_n
			spi0_MISO                      : in    std_logic                     := 'X';             -- MISO
			spi0_MOSI                      : out   std_logic;                                        -- MOSI
			spi0_SCLK                      : out   std_logic;                                        -- SCLK
			spi0_SS_n                      : out   std_logic;                                        -- SS_n
			usb_gpx_export                 : in    std_logic                     := 'X';             -- export
			usb_irq_export                 : in    std_logic                     := 'X';             -- export
			usb_rst_export                 : out   std_logic;                                        -- export
			win_pio_export                 : out   std_logic_vector(1 downto 0)                      -- export
		);
	end component final_project;

	u0 : component final_project
		port map (
			accumulate_wire_export         => CONNECTED_TO_accumulate_wire_export,         --         accumulate_wire.export
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                     clk.clk
			grid_pio0_export               => CONNECTED_TO_grid_pio0_export,               --               grid_pio0.export
			grid_pio1_export               => CONNECTED_TO_grid_pio1_export,               --               grid_pio1.export
			grid_pio10_export              => CONNECTED_TO_grid_pio10_export,              --              grid_pio10.export
			grid_pio11_export              => CONNECTED_TO_grid_pio11_export,              --              grid_pio11.export
			grid_pio12_export              => CONNECTED_TO_grid_pio12_export,              --              grid_pio12.export
			grid_pio13_export              => CONNECTED_TO_grid_pio13_export,              --              grid_pio13.export
			grid_pio14_export              => CONNECTED_TO_grid_pio14_export,              --              grid_pio14.export
			grid_pio15_export              => CONNECTED_TO_grid_pio15_export,              --              grid_pio15.export
			grid_pio2_export               => CONNECTED_TO_grid_pio2_export,               --               grid_pio2.export
			grid_pio3_export               => CONNECTED_TO_grid_pio3_export,               --               grid_pio3.export
			grid_pio4_export               => CONNECTED_TO_grid_pio4_export,               --               grid_pio4.export
			grid_pio5_export               => CONNECTED_TO_grid_pio5_export,               --               grid_pio5.export
			grid_pio6_export               => CONNECTED_TO_grid_pio6_export,               --               grid_pio6.export
			grid_pio7_export               => CONNECTED_TO_grid_pio7_export,               --               grid_pio7.export
			grid_pio8_export               => CONNECTED_TO_grid_pio8_export,               --               grid_pio8.export
			grid_pio9_export               => CONNECTED_TO_grid_pio9_export,               --               grid_pio9.export
			hex_digits_export              => CONNECTED_TO_hex_digits_export,              --              hex_digits.export
			key_external_connection_export => CONNECTED_TO_key_external_connection_export, -- key_external_connection.export
			keycode_export                 => CONNECTED_TO_keycode_export,                 --                 keycode.export
			leds_export                    => CONNECTED_TO_leds_export,                    --                    leds.export
			reset_reset_n                  => CONNECTED_TO_reset_reset_n,                  --                   reset.reset_n
			sdram_clk_clk                  => CONNECTED_TO_sdram_clk_clk,                  --               sdram_clk.clk
			sdram_wire_addr                => CONNECTED_TO_sdram_wire_addr,                --              sdram_wire.addr
			sdram_wire_ba                  => CONNECTED_TO_sdram_wire_ba,                  --                        .ba
			sdram_wire_cas_n               => CONNECTED_TO_sdram_wire_cas_n,               --                        .cas_n
			sdram_wire_cke                 => CONNECTED_TO_sdram_wire_cke,                 --                        .cke
			sdram_wire_cs_n                => CONNECTED_TO_sdram_wire_cs_n,                --                        .cs_n
			sdram_wire_dq                  => CONNECTED_TO_sdram_wire_dq,                  --                        .dq
			sdram_wire_dqm                 => CONNECTED_TO_sdram_wire_dqm,                 --                        .dqm
			sdram_wire_ras_n               => CONNECTED_TO_sdram_wire_ras_n,               --                        .ras_n
			sdram_wire_we_n                => CONNECTED_TO_sdram_wire_we_n,                --                        .we_n
			spi0_MISO                      => CONNECTED_TO_spi0_MISO,                      --                    spi0.MISO
			spi0_MOSI                      => CONNECTED_TO_spi0_MOSI,                      --                        .MOSI
			spi0_SCLK                      => CONNECTED_TO_spi0_SCLK,                      --                        .SCLK
			spi0_SS_n                      => CONNECTED_TO_spi0_SS_n,                      --                        .SS_n
			usb_gpx_export                 => CONNECTED_TO_usb_gpx_export,                 --                 usb_gpx.export
			usb_irq_export                 => CONNECTED_TO_usb_irq_export,                 --                 usb_irq.export
			usb_rst_export                 => CONNECTED_TO_usb_rst_export,                 --                 usb_rst.export
			win_pio_export                 => CONNECTED_TO_win_pio_export                  --                 win_pio.export
		);

