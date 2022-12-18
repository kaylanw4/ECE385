module game_image_mapper (
	input logic [9:0] DrawX, DrawY,
	input logic vga_clk, blank, vs,
	input logic [1:0] win_lose,
	input logic	[15:0] grid [16],
	output logic [3:0] red, green, blue
);

logic [19:0] rom_address;
logic [11:0] rom_address_sprites [11];
logic [14:0] rom_address_wl [2];
logic [3:0] rom_q;
logic [4:0] rom_q_win, rom_q_lose;
logic [4:0] rom_q_sprites [11];


logic [3:0] palette_red[14];
logic [3:0] palette_green[14]; 
logic [3:0] palette_blue[14];

logic [10:0][15:0][9:0] BallX; // [tile] [grid location] [pixel]
logic [10:0][15:0][9:0] BallY;
logic [9:0] win_loseX [2];
logic [9:0] win_loseY [2];

logic [8:0] location [8];


// initialize locations for the tiles 
always_comb
begin
	for (int i = 0; i < 8; i++) begin
		if (i < 4)
			location[i] = (204 + (i*61));
		else
			location[i] = (175 + ((i-4)*80));
	end
end
/*always_comb begin
	
	for (int i = 0; i < 16; i++) begin
		if (i % 2 == 0)
			grid[i] = 2;
		else
			grid[i] = 4;
				
	end
end*/


always_comb begin
	for (int i = 0; i < 11; i++) begin
		for (int j = 0; j < 16; j++) begin
			BallX[i][j] = 641;
			BallY[i][j] = 481;
		end
	end
	for (int i = 0; i < 11; i++) begin
		for (int j = 0; j < 16; j++) begin
			if (grid[j] == 2**(i+1)) begin
				BallX[i][j] = location[j%4];
				BallY[i][j] = location[(j/4)+4];
			end
		end
	end
end



assign rom_address = (DrawX*640/640) + (DrawY*480/480 * 640);
always_comb
begin
	rom_address_sprites[0] = 0;
	rom_address_sprites[1] = 0;
	rom_address_sprites[2] = 0;
	rom_address_sprites[3] = 0;
	rom_address_sprites[4] = 0;
	rom_address_sprites[5] = 0;
	rom_address_sprites[6] = 0;
	rom_address_sprites[7] = 0;
	rom_address_sprites[8] = 0;
	rom_address_sprites[9] = 0;
	rom_address_sprites[10] = 0;

	for (int i = 0; i < 16; i++) begin
		for (int j = 0; j < 11; j++) begin
			if ((DrawX >= BallX[j][i]) && (DrawY >= BallY[j][i]) && (DrawX <= BallX[j][i]+48) && (DrawY <= BallY[j][i]+64))
				rom_address_sprites[j] = (DrawX-BallX[j][i]) + ((DrawY-BallY[j][i]) * 48);
		end
	end

end

		
always_comb
begin
	win_loseX[0] = 641;
	win_loseY[0] = 481;
	win_loseX[1] = 641;
	win_loseY[1] = 481;
	if (win_lose == 1) begin
		win_loseX[0] = 170;
		win_loseY[0] = 190;
	end
	else if (win_lose == 2) begin
		win_loseX[1] = 170;
		win_loseY[1] = 190;
	end
		
end


always_comb
begin
	rom_address_wl[0] = 0;
	rom_address_wl[1] = 0;
	
	for (int i = 0; i < 2; i++) begin
		if ((DrawX >= win_loseX[i]) && (DrawY >= win_loseY[i]) && 
			(DrawX <= win_loseX[i]+300) && (DrawY <= win_loseY[i]+100))
			rom_address_wl[i] = (DrawX-win_loseX[i]) + ((DrawY-win_loseY[i]) * 300);

	end

end

logic [3:0] Red, Green, Blue;

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		red <= Red[3:0];
		green <= Green[3:0];
		blue <= Blue[3:0];
	end
end

// background instantiations
game_image_rom rom (
	.clock   (vga_clk), 
	.address (rom_address),
	.q       (rom_q)
);

game_image_palette palette (
	.index (rom_q),
	.red   (palette_red[0]),
	.green (palette_green[0]),
	.blue  (palette_blue[0])
);

// 2 tile instatianations

color_mapper cm (.*, .BallX(BallX), .BallY(BallY), 
					.palette_red(palette_red), 
					.palette_green(palette_green), 
					.palette_blue(palette_blue), 
					.DrawX(DrawX), .DrawY(DrawY), 
					.win_lose(win_lose),
					.Red(Red), .Green(Green), .Blue(Blue));

tile_2_pic_palette palette2 (
	.index (rom_q_sprites[0]),
	.red   (palette_red[1]),
	.green (palette_green[1]),
	.blue  (palette_blue[1])
);

tile_2_pic_rom rom2 (
	.clock   (vga_clk),
	.address (rom_address_sprites[0]),
	.q       (rom_q_sprites[0])
);

// 4 tile

tile_4_pic_palette palette4 (
	.index (rom_q_sprites[1]),
	.red   (palette_red[2]),
	.green (palette_green[2]),
	.blue  (palette_blue[2])
);

tile_4_pic_rom rom4 (
	.clock   (vga_clk),
	.address (rom_address_sprites[1]),
	.q       (rom_q_sprites[1])
);



// 8 tile
tile_8_pic_palette palette8 (
	.index (rom_q_sprites[2]),
	.red   (palette_red[3]),
	.green (palette_green[3]),
	.blue  (palette_blue[3])
);

tile_8_pic_rom rom8 (
	.clock   (vga_clk),
	.address (rom_address_sprites[2]),
	.q       (rom_q_sprites[2])
);
// 16 tile
tile_16_pic_palette palette16 (
	.index (rom_q_sprites[3]),
	.red   (palette_red[4]),
	.green (palette_green[4]),
	.blue  (palette_blue[4])
);

tile_16_pic_rom rom16 (
	.clock   (vga_clk),
	.address (rom_address_sprites[3]),
	.q       (rom_q_sprites[3])
);
// 32 tile
tile_32_pic_palette palette32 (
	.index (rom_q_sprites[4]),
	.red   (palette_red[5]),
	.green (palette_green[5]),
	.blue  (palette_blue[5])
);

tile_32_pic_rom rom32 (
	.clock   (vga_clk),
	.address (rom_address_sprites[4]),
	.q       (rom_q_sprites[4])
);
// 64 tile
tile_64_pic_palette palette64 (
	.index (rom_q_sprites[5]),
	.red   (palette_red[6]),
	.green (palette_green[6]),
	.blue  (palette_blue[6])
);

tile_64_pic_rom rom64 (
	.clock   (vga_clk),
	.address (rom_address_sprites[5]),
	.q       (rom_q_sprites[5])
);
// 128 tile
tile_128_pic_palette palette128 (
	.index (rom_q_sprites[6]),
	.red   (palette_red[7]),
	.green (palette_green[7]),
	.blue  (palette_blue[7])
);

tile_128_pic_rom rom128 (
	.clock   (vga_clk),
	.address (rom_address_sprites[6]),
	.q       (rom_q_sprites[6])
);
// 256 tile
tile_256_pic_palette palette256 (
	.index (rom_q_sprites[7]),
	.red   (palette_red[8]),
	.green (palette_green[8]),
	.blue  (palette_blue[8])
);

tile_256_pic_rom rom256 (
	.clock   (vga_clk),
	.address (rom_address_sprites[7]),
	.q       (rom_q_sprites[7])
);

win_2048_pic_rom win_2048_pic_rom (
	.clock   (vga_clk),
	.address (rom_address_wl[0]),
	.q       (rom_q_win)
);

win_2048_pic_palette win_2048_pic_palette (
	.index (rom_q_win),
	.red   (palette_red[12]),
	.green (palette_green[12]),
	.blue  (palette_blue[12])
);

lose_2048_pic_rom lose_2048_pic_rom (
	.clock   (vga_clk),
	.address (rom_address_wl[1]),
	.q       (rom_q_lose)
);

lose_2048_pic_palette lose_2048_pic_palette (
	.index (rom_q_lose),
	.red   (palette_red[13]),
	.green (palette_green[13]),
	.blue  (palette_blue[13])
);
// 512 tile

// 1024 tile

// 2048 tile

endmodule
