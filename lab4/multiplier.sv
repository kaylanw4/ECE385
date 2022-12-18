module multiplier (
	input logic [7:0] SW,
	input logic Clk, Reset_Load_Clear, Run,
	output logic [6:0] HEX1, HEX0, HEX3, HEX2, HEX4, HEX5,
	output logic [7:0] Aval, Bval,
	output logic Xval

);
	
	logic [16:0] In, Out;
	logic [8:0] Sum;
	logic Reset_h, Run_h;
	logic Load, Shift, cout, Add_En, shiftout, shiftout1;
	
	// Misc logic that inverts button presses 
	
	always_comb	
	begin
			Reset_h = ~Reset_Load_Clear;
			Run_h = ~Run;

	end

	control run (.*, .Reset(Reset_h), .Run(Run_h), .LSBB(Out[1:0]), .Run_O(Load), .Shift_En(Shift), .Add_En(Add_En));

	reg_8 A (.*, .Reset(Reset_h), .Load(Load), .Shift_En(Shift), .Shift_In(Out[15]), .D(Sum[7:0]), .Data_Out(Out[15:8]), .Shift_Out(shiftout));
	reg_8 B (.*, .Reset(), .Load(Reset_h), .Shift_En(Shift), .Shift_In(shiftout), .D(In[7:0]), .Data_Out(Out[7:0]), .Shift_Out(shiftout1));
	reg_1 X (.*, .Reset(Reset_h), .Load(Load), .Shift_En(Shift), .D(Out[15]), .Data_Out(Out[16]));
	
	//reg_A a	( .*, .Reset(Reset_h), .Load(Load), .Shift_En(Shift), .D(In[7:0]), .S(Sum[7:0]), .Diff(Diff[7:0]), .Data_Out(Out[16:0]));
	
	router route ( .R(Load), .A_In(SW[7:0]), .B_In(Out[16:0]), .Q_Out(In[16:0]) );
	
	ripple_adder adder (.A(Out[15:8]), .B(SW[7:0]), .cin(0), .Add_En(Add_En), .S(Sum[8:0]), .cout(cout));
	
	//counter count8 (.*, .Count_En(Count_En), .count(count));
	
	assign Aval = Out[15:8];
	assign Bval = Out[7:0];
	assign Xval = Out[16];

		HexDriver		AHex0 (
								.In0(SW[3:0]),
								.Out0(HEX0) );
								
		HexDriver		AHex1 (
								.In0(SW[7:4]),
								.Out0(HEX1) );
								
		HexDriver		BHex0 (
								.In0(Out[3:0]),
								.Out0(HEX2) );
								
		HexDriver		BHex1 (
								.In0(Out[7:4]),
								.Out0(HEX3) );
		
		HexDriver		BHex2 (
								.In0(Out[11:8]),
								.Out0(HEX4) );
								
		HexDriver		BHex3 (
								.In0(Out[15:12]),
								.Out0(HEX5) );

endmodule 