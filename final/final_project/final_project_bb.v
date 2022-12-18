
module final_project (
	accumulate_wire_export,
	clk_clk,
	grid_pio0_export,
	grid_pio1_export,
	grid_pio10_export,
	grid_pio11_export,
	grid_pio12_export,
	grid_pio13_export,
	grid_pio14_export,
	grid_pio15_export,
	grid_pio2_export,
	grid_pio3_export,
	grid_pio4_export,
	grid_pio5_export,
	grid_pio6_export,
	grid_pio7_export,
	grid_pio8_export,
	grid_pio9_export,
	hex_digits_export,
	key_external_connection_export,
	keycode_export,
	leds_export,
	reset_reset_n,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	spi0_MISO,
	spi0_MOSI,
	spi0_SCLK,
	spi0_SS_n,
	usb_gpx_export,
	usb_irq_export,
	usb_rst_export,
	win_pio_export);	

	input		accumulate_wire_export;
	input		clk_clk;
	output	[15:0]	grid_pio0_export;
	output	[15:0]	grid_pio1_export;
	output	[15:0]	grid_pio10_export;
	output	[15:0]	grid_pio11_export;
	output	[15:0]	grid_pio12_export;
	output	[15:0]	grid_pio13_export;
	output	[15:0]	grid_pio14_export;
	output	[15:0]	grid_pio15_export;
	output	[15:0]	grid_pio2_export;
	output	[15:0]	grid_pio3_export;
	output	[15:0]	grid_pio4_export;
	output	[15:0]	grid_pio5_export;
	output	[15:0]	grid_pio6_export;
	output	[15:0]	grid_pio7_export;
	output	[15:0]	grid_pio8_export;
	output	[15:0]	grid_pio9_export;
	output	[15:0]	hex_digits_export;
	input	[1:0]	key_external_connection_export;
	output	[7:0]	keycode_export;
	output	[13:0]	leds_export;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input		spi0_MISO;
	output		spi0_MOSI;
	output		spi0_SCLK;
	output		spi0_SS_n;
	input		usb_gpx_export;
	input		usb_irq_export;
	output		usb_rst_export;
	output	[1:0]	win_pio_export;
endmodule
