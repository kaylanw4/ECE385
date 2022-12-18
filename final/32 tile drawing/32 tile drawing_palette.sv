module tile_32_pic_palette (
	input logic [4:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [32];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h3, 4'h8, 4'hE};
	palette[01] = {4'h0, 4'h0, 4'h1};
	palette[02] = {4'h3, 4'h5, 4'h9};
	palette[03] = {4'h0, 4'h2, 4'h4};
	palette[04] = {4'h4, 4'h7, 4'hC};
	palette[05] = {4'h2, 4'h3, 4'h6};
	palette[06] = {4'h0, 4'h0, 4'h0};
	palette[07] = {4'h3, 4'h6, 4'hB};
	palette[08] = {4'h0, 4'h1, 4'h2};
	palette[09] = {4'h2, 4'h4, 4'h7};
	palette[10] = {4'h4, 4'h7, 4'hD};
	palette[11] = {4'h1, 4'h3, 4'h5};
	palette[12] = {4'h4, 4'h8, 4'hD};
	palette[13] = {4'h1, 4'h2, 4'h3};
	palette[14] = {4'h2, 4'h4, 4'h8};
	palette[15] = {4'h3, 4'h6, 4'hA};
	palette[16] = {4'h3, 4'h7, 4'hC};
	palette[17] = {4'h2, 4'h5, 4'h9};
	palette[18] = {4'h3, 4'h5, 4'hA};
	palette[19] = {4'h1, 4'h1, 4'h3};
	palette[20] = {4'h0, 4'h1, 4'h1};
	palette[21] = {4'h1, 4'h2, 4'h5};
	palette[22] = {4'h0, 4'h1, 4'h3};
	palette[23] = {4'h2, 4'h5, 4'h8};
	palette[24] = {4'h3, 4'h6, 4'hC};
	palette[25] = {4'h1, 4'h3, 4'h6};
	palette[26] = {4'h4, 4'h8, 4'hE};
	palette[27] = {4'h4, 4'h8, 4'hE};
	palette[28] = {4'h4, 4'h8, 4'hE};
	palette[29] = {4'h4, 4'h8, 4'hE};
	palette[30] = {4'h4, 4'h8, 4'hE};
	palette[31] = {4'h4, 4'h8, 4'hE};
end

endmodule
