module tile_256_pic_palette (
	input logic [4:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [32];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h4, 4'h3, 4'h1};
	palette[01] = {4'hE, 4'hD, 4'h6};
	palette[02] = {4'h0, 4'h0, 4'h0};
	palette[03] = {4'hA, 4'h9, 4'h4};
	palette[04] = {4'h7, 4'h6, 4'h2};
	palette[05] = {4'hD, 4'hB, 4'h5};
	palette[06] = {4'h0, 4'h1, 4'h0};
	palette[07] = {4'h6, 4'h4, 4'h1};
	palette[08] = {4'hE, 4'hC, 4'h5};
	palette[09] = {4'h7, 4'h7, 4'h3};
	palette[10] = {4'h9, 4'h8, 4'h3};
	palette[11] = {4'hB, 4'h9, 4'h4};
	palette[12] = {4'hC, 4'hA, 4'h5};
	palette[13] = {4'h3, 4'h2, 4'h1};
	palette[14] = {4'h5, 4'h4, 4'h2};
	palette[15] = {4'hF, 4'hC, 4'h6};
	palette[16] = {4'h2, 4'h2, 4'h0};
	palette[17] = {4'hC, 4'hA, 4'h4};
	palette[18] = {4'h3, 4'h3, 4'h1};
	palette[19] = {4'hA, 4'h8, 4'h4};
	palette[20] = {4'h7, 4'h6, 4'h2};
	palette[21] = {4'h1, 4'h0, 4'h0};
	palette[22] = {4'h9, 4'h6, 4'h2};
	palette[23] = {4'h8, 4'h6, 4'h3};
	palette[24] = {4'h2, 4'h1, 4'h0};
	palette[25] = {4'hB, 4'hA, 4'h4};
	palette[26] = {4'h4, 4'h4, 4'h1};
	palette[27] = {4'h7, 4'h5, 4'h2};
	palette[28] = {4'h2, 4'h2, 4'h1};
	palette[29] = {4'hE, 4'hB, 4'h5};
	palette[30] = {4'hC, 4'hB, 4'h5};
	palette[31] = {4'h5, 4'h5, 4'h2};
end

endmodule
