module testbench();

	timeunit 10ns;
	timeprecision 1ns;
	
	logic [7:0] SW;
	logic Clk, Reset_Load_Clear, Run;
	logic [6:0] HEX1, HEX0, HEX3, HEX2, HEX4, HEX5;
	logic [7:0] Aval, Bval;
	logic Xval;
	
	multiplier asdf(.*);
	
	initial begin
		Clk = 1'b0;
	end
	
	always begin
		#1 Clk = ~Clk;
	end
	
	initial begin: TEST_VECTORS
	
	SW = 8'b00000000;
	Reset_Load_Clear = 1'b1;
	Run = 1'b1;
	
	#2 SW = 8'hc5;
	Reset_Load_Clear = 1'b0;
	
	#2 
	Reset_Load_Clear = 1'b1;
	
	#2
	SW = 8'h07;
	Run = 1'b0;
	
	#2
	Run = 1'b1;
	
	#32 Reset_Load_Clear = 1'b1;
	Run = 1'b1;
	
	#2 //SW = 8'hc5;
	Reset_Load_Clear = 1'b0;
	
	#2 
	Reset_Load_Clear = 1'b1;
	
	#2
	SW = 8'hc5;
	Run = 1'b0;
	
	#2
	Run = 1'b1;
	
	#32 Reset_Load_Clear = 1'b1;
	Run = 1'b1;
	
	#2 SW = 8'hff;
	Reset_Load_Clear = 1'b0;
	
	#2 
	Reset_Load_Clear = 1'b1;
	
	#2
	SW = 8'hff;
	Run = 1'b0;
	
	#2
	Run = 1'b1;
	
	#32 Reset_Load_Clear = 1'b1;
	Run = 1'b1;
	
	#2 SW = 8'h05;
	Reset_Load_Clear = 1'b0;
	
	#2 
	Reset_Load_Clear = 1'b1;
	
	#2
	SW = 8'h05;
	Run = 1'b0;
	
	#2
	Run = 1'b1;
	
	/*#50
	SW = 8'hFF;
	Run = 1'b0;
	
	#2
	Run = 1'b1;
	
	#50
	SW = 8'hFF;
	Run = 1'b0;
	
	#2
	Run = 1'b1;
	
	#50
	SW = 8'hFF;
	Run = 1'b0;
	
	#2
	Run = 1'b1;*/

	end


endmodule 