module game_image_rom (
	input logic clock,
	input logic [18:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:307199] /* synthesis ram_init_file = "./2048 game image/2048 game image.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
