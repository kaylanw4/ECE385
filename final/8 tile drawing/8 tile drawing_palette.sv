module tile_8_pic_palette (
	input logic [4:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [32];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hC, 4'hE, 4'hE};
	palette[02] = {4'h9, 4'h9, 4'hA};
	palette[03] = {4'h5, 4'h6, 4'h6};
	palette[04] = {4'h2, 4'h2, 4'h2};
	palette[05] = {4'hB, 4'hC, 4'hC};
	palette[06] = {4'h7, 4'h8, 4'h8};
	palette[07] = {4'hC, 4'hD, 4'hE};
	palette[08] = {4'h1, 4'h1, 4'h1};
	palette[09] = {4'h4, 4'h4, 4'h4};
	palette[10] = {4'hA, 4'hB, 4'hC};
	palette[11] = {4'h9, 4'hA, 4'hB};
	palette[12] = {4'h6, 4'h7, 4'h7};
	palette[13] = {4'h2, 4'h2, 4'h3};
	palette[14] = {4'h4, 4'h5, 4'h5};
	palette[15] = {4'h8, 4'h9, 4'hA};
	palette[16] = {4'h5, 4'h5, 4'h6};
	palette[17] = {4'h7, 4'h8, 4'h9};
	palette[18] = {4'h3, 4'h3, 4'h3};
	palette[19] = {4'h7, 4'h7, 4'h8};
	palette[20] = {4'hC, 4'hD, 4'hF};
	palette[21] = {4'h6, 4'h6, 4'h7};
	palette[22] = {4'hB, 4'hD, 4'hE};
	palette[23] = {4'h8, 4'h8, 4'h9};
	palette[24] = {4'h1, 4'h2, 4'h2};
	palette[25] = {4'h1, 4'h1, 4'h2};
	palette[26] = {4'h0, 4'h1, 4'h1};
	palette[27] = {4'h6, 4'h7, 4'h8};
	palette[28] = {4'h5, 4'h5, 4'h5};
	palette[29] = {4'h3, 4'h3, 4'h4};
	palette[30] = {4'h8, 4'h9, 4'h9};
	palette[31] = {4'hA, 4'hA, 4'hB};
end

endmodule
