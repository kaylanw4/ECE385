
/*module full_subtract (input logic x, y, z,
						 output logic s, c);
						 
	assign s = x^y^z;
	assign c = (x&y)|(y&z)|(x&z);
	
endmodule

module ripple_subtract
(
	input  [8:0] A, B,
	input         cin,
	input 		  Sub_en,
	output [8:0] S,
	output        cout
); 

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. 
	  
	logic [8:0] Asub;
	assign Asub = ~A; // probably can't do this but ask CA

   logic c0, c1, c2, c3, c4, c5, c6, c7;
	  
	full_adder FA9 (.x (Asub[0]), .y (B[0]), .z (1), .s (S[0]), .c (c0));
	full_adder FA10 (.x (Asub[1]), .y (B[1]), .z (c0), .s (S[1]), .c (c1));
	full_adder FA11 (.x (Asub[2]), .y (B[2]), .z (c1), .s (S[2]), .c (c2));
	full_adder FA12 (.x (Asub[3]), .y (B[3]), .z (c2), .s (S[3]), .c (c3));
	full_adder FA13 (.x (Asub[4]), .y (B[4]), .z (c3), .s (S[4]), .c (c4));
	full_adder FA14 (.x (Asub[5]), .y (B[5]), .z (c4), .s (S[5]), .c (c5));
	full_adder FA15 (.x (Asub[6]), .y (B[6]), .z (c5), .s (S[6]), .c (c6));
	full_adder FA16 (.x (Asub[7]), .y (B[7]), .z (c6), .s (S[7]), .c (c7));
	full_adder FA17 (.x (Asub[8]), .y (B[8]), .z (c7), .s (S[8]), .c (cout));

endmodule*/