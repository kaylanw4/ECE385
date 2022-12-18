module testbench ();

	timeunit 10ns;
	timeprecision 1ns;


	logic [9:0] SW;
	logic	Clk, Run, Continue;
	logic [9:0] LED;
	logic [6:0] HEX0, HEX1, HEX2, HEX3;


	slc3_testtop slc3_test(.*);

	initial begin
		Clk = 1'b0;
	end
	
	always begin
		#1 Clk = ~Clk;
	end

	initial begin: TEST_VECTORS
	
	Run = 1'b1;
	Continue = 1'b1;
	SW = 10'b0000101010;
	
	#10 Run = 1'b0;
	Continue = 1'b0;
	
	#3 Continue = 1'b1;
	#3 Run = 1'b1;
	
	#150 Continue = 1'b0;
	#3 Continue = 1'b1;
	#80 Continue = 1'b0;
	#3 Continue = 1'b1;
	#80 Continue = 1'b0;
	#3 Continue = 1'b1;
	#80 Continue = 1'b0;
	#3 Continue = 1'b1;
	#80 Continue = 1'b0;
	#3 Continue = 1'b1;
	#80 Continue = 1'b0;
	#3 Continue = 1'b1;
	#80 Continue = 1'b0;
	#3 Continue = 1'b1;
	

	
	/*#130 SW = 10'b0000000010;
	#6 Continue = 1'b0;
	#3 Continue = 1'b1;
	
	
	
	#25000 SW = 10'b0000000011;
	#3 Continue = 1'b0;
	#3 Continue = 1'b1;
	#350 Continue = 1'b0;
	#3 Continue = 1'b1;
	#170 //SW = 10'b0000000010;
	#3 Continue = 1'b0;
	#3 Continue = 1'b1;
	#170 //SW = 10'b0000000011;
	#3 Continue = 1'b0;
	#3 Continue = 1'b1;
	#170 //SW = 10'b0000000010;
	#3 Continue = 1'b0;
	#3 Continue = 1'b1;
	#170 //SW = 10'b0000000010;
	#3 Continue = 1'b0;
	#3 Continue = 1'b1;*/
	
	
	//#10 Continue = 1'b1;
	//Run = 1'b0;
	
	//#10 Continue = 1'b0;
	//Run = 1'b1;
	
	//#10 Continue = 1'b1;
	//Run = 1'b0;
	
	//#10 Continue = 1'b0;
	//Run = 1'b1;
	
	//#10 Continue = 1'b1;
	//Run = 1'b0;
	
	//#10 Continue = 1'b0;
	//Run = 1'b1;

	
	end
	
endmodule
