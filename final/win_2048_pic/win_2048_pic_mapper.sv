module win_2048_pic_mapper (
	input logic [9:0] DrawX, DrawY,
	input logic vga_clk, blank,
	output logic [3:0] red, green, blue
);

logic [15:0] rom_address;
logic [5:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

assign rom_address = (DrawX*300/640) + (DrawY*100/480 * 300);

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
	end
end

win_2048_pic_rom win_2048_pic_rom (
	.clock   (vga_clk),
	.address (rom_address),
	.q       (rom_q)
);

win_2048_pic_palette win_2048_pic_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
