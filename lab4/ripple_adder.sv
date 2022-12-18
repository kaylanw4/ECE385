//adding s to a

module full_adder (input logic x, y, z,
						 output logic s, c);
						 
	assign s = x^y^z;
	assign c = (x&y)|(y&z)|(x&z);
	
endmodule

module ripple_adder
(
	input  [7:0] A, B,
	input         cin,
	input  Add_En,
	output [8:0] S,
	output        cout
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	logic c_out, c_in;
	logic [8:0] S_0, S_1;
   
	  addition asdf (.A(A[7:0]), .B(B[7:0]), .cin(cin), .S_1(S_1[8:0]), .cout(c_out));
	  subtract asdfasdf (.A(A[7:0]), .B(B[7:0]), .cin(cin), .S_0(S_0[8:0]), .cout(c_out));

	  
	  // select which adder to get sum from based on logic 
	  mux2 mux74 (.Din1(S_1[8:0]), .Din0(S_0[8:0]), .sel(Add_En), .Dout(S[8:0]));


endmodule


// 2-to-1 mux module
module mux2 (
	input logic [8:0] Din1, Din0,
	input logic sel,
	output logic [8:0] Dout
); 

always_comb

begin
	if (sel == 0)	
		Dout = Din0;
	else 
		Dout = Din1;
end

endmodule


module addition(
	input  [7:0] A, B,
	input         cin,
	output [8:0] S_1,
	output        cout
);



	logic c0, c1, c2, c3, c4, c5, c6, c7;
	logic Asext, Bsext;
	
	assign Asext = A[7];
	assign Bsext = B[7];
	  
  
	full_adder FA0 (.x (A[0]), .y (B[0]), .z (0), .s (S_1[0]), .c (c0));
	full_adder FA1 (.x (A[1]), .y (B[1]), .z (c0), .s (S_1[1]), .c (c1));
	full_adder FA2 (.x (A[2]), .y (B[2]), .z (c1), .s (S_1[2]), .c (c2));
	full_adder FA3 (.x (A[3]), .y (B[3]), .z (c2), .s (S_1[3]), .c (c3));
	full_adder FA4 (.x (A[4]), .y (B[4]), .z (c3), .s (S_1[4]), .c (c4));
	full_adder FA5 (.x (A[5]), .y (B[5]), .z (c4), .s (S_1[5]), .c (c5));
	full_adder FA6 (.x (A[6]), .y (B[6]), .z (c5), .s (S_1[6]), .c (c6));
	full_adder FA7 (.x (A[7]), .y (B[7]), .z (c6), .s (S_1[7]), .c (c7));
	full_adder FA8 (.x (Asext), .y (Bsext), .z (c7), .s (S_1[8]), .c (cout));
	
endmodule


module subtract(
	input  [7:0] A, B,
	input         cin,
	output [8:0] S_0,
	output        cout
);

	logic c0, c1, c2, c3, c4, c5, c6, c7;
	logic Asext, Bsext;
	
	assign Asext = A[7];
	assign Bsext = ~B[7];
	  
	logic [8:0] Bsub;
	assign Bsub = ~B;
	  
	full_adder FA9 (.x (A[0]), .y (Bsub[0]), .z (1), .s (S_0[0]), .c (c0));
	full_adder FA10 (.x (A[1]), .y (Bsub[1]), .z (c0), .s (S_0[1]), .c (c1));
	full_adder FA11 (.x (A[2]), .y (Bsub[2]), .z (c1), .s (S_0[2]), .c (c2));
	full_adder FA12 (.x (A[3]), .y (Bsub[3]), .z (c2), .s (S_0[3]), .c (c3));
	full_adder FA13 (.x (A[4]), .y (Bsub[4]), .z (c3), .s (S_0[4]), .c (c4));
	full_adder FA14 (.x (A[5]), .y (Bsub[5]), .z (c4), .s (S_0[5]), .c (c5));
	full_adder FA15 (.x (A[6]), .y (Bsub[6]), .z (c5), .s (S_0[6]), .c (c6));
	full_adder FA16 (.x (A[7]), .y (Bsub[7]), .z (c6), .s (S_0[7]), .c (c7));
	full_adder FA17 (.x (Asext), .y (Bsext), .z (c7), .s (S_0[8]), .c (cout));


endmodule 