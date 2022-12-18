module game_image_palette (
	input logic [2:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [8];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hE, 4'hE, 4'hE};
	palette[01] = {4'hC, 4'hC, 4'hB};
	palette[02] = {4'hA, 4'h9, 4'h9};
	palette[03] = {4'h6, 4'h6, 4'h6};
	palette[04] = {4'hC, 4'hB, 4'hA};
	palette[05] = {4'hA, 4'h9, 4'h9};
	palette[06] = {4'hB, 4'hB, 4'hA};
	palette[07] = {4'h8, 4'h8, 4'h7};
end

endmodule
