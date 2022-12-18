
module reg_8 ( input						Clk, Reset, Load, Shift_En, Shift_In,
					input						[7:0] D,
					output logic 			[7:0] Data_Out,
					output logic 			Shift_Out);
					
		always_ff @ (posedge Clk or posedge Reset)
		begin
				// Setting the output Q[16..0] of the register to zeros as Reset is pressed
				if(Reset)
					Data_Out <= 8'b00000000;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else if(Load)
					Data_Out <= D;
				else if (Shift_En)
					 begin
						  //concatenate shifted in data to the previous left-most 3 bits
						  //note this works because we are in always_ff procedure block
						  Data_Out <= {Shift_In, Data_Out[7:1] }; 
					 end
				
		end
		assign Shift_Out = Data_Out[0];

		
		
endmodule

module reg_1 ( input						Clk, Reset, Load, Shift_En,
					input						D,
					output logic 			Data_Out);
					
		always_ff @ (posedge Clk or posedge Reset)
		begin
				// Setting the output Q[16..0] of the register to zeros as Reset is pressed
				if(Reset)
					Data_Out <= 1'b0;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else if(Load||Shift_En)
					Data_Out <= D;

		end

		
		
endmodule






/*
module reg_A (input	logic		Clk, Reset, Load, Shift_En, Add, Sub, 
					input	logic		[7:0] D, S, Diff,
					output logic 	[16:0] Data_Out);
					
		logic [7:0] A_Data_Next, B_Data_Next;
		logic X;
		
		// A shift register 		
		always_ff @ (posedge Clk)
		begin

			X <= A_Data_Next[7]; // sign extention
			Data_Out[16:8] <= {X, A_Data_Next};
			
		end
		
		always_comb
		begin
				A_Data_Next = Data_Out[15:8];
				if(Reset) // reset the register to 0 when reset
					A_Data_Next = 8'b00000000;
				else if(Add)
					A_Data_Next = S;
				else if(Sub)
					A_Data_Next = Diff;
				else if(Shift_En) // shift X into A
					A_Data_Next = {X, Data_Out[15:9]};
		end
		
		// B shift register 		
		always_ff @ (posedge Clk)
		begin

			Data_Out[7:0] <= B_Data_Next;
			
		end
		
		always_comb
		begin
				B_Data_Next = Data_Out[7:0];
				if(Reset) // reset the register to 0 when reset
					B_Data_Next = 8'b00000000;
				else if(Load) // Load switch data into B
					B_Data_Next = D;
				else if(Shift_En) // shift X into A
					B_Data_Next = Data_Out[8:1];
		end
		
endmodule */