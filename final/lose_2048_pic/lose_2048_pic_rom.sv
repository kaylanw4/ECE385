module lose_2048_pic_rom (
	input logic clock,
	input logic [14:0] address,
	output logic [4:0] q
);

logic [4:0] memory [0:29999] /* synthesis ram_init_file = "./lose_2048_pic/lose_2048_pic.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
