module control (	input Clk, Reset, Run, 
						input [1:0]LSBB,
						output logic Run_O, Shift_En, Add_En);
						
		enum logic [5:0] {A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R} curr_state, next_state; // States
		// Assign 'next_state' based on 'state' and 'Execute'
		always_ff @ (posedge Clk or posedge Reset ) 
		begin
				if (Reset)
					curr_state <= A; 
				else
					curr_state <= next_state;
		end
		// Assign outputs based on ‘state’
		always_comb
		begin
		// Default to be self-looping 	
			//control unit is really important, this is where we move from one state to the next
			//need to set conditions for when to move from shift to add to halt etc.
				next_state = curr_state; 
				
				unique case (curr_state)
						A : // clear XA
							if(Run && LSBB[0])
								next_state = Q;
							else if (Run && ~LSBB[0])
								next_state = B;
				
						B : // Shift1
							if(LSBB[1])
								next_state = J;
							else
								next_state = C;
						C : // Shift2
							if(LSBB[1])
								next_state = K;
							else
								next_state = D;
						D : // Shift3
							if(LSBB[1])
								next_state = L;
							else
								next_state = E;
						E : // Shift4
							if(LSBB[1])
								next_state = M;
							else
								next_state = F;
						F : // Shift5
							if(LSBB[1])
								next_state = N;
							else
								next_state = G;
						G : // Shift6
							if(LSBB[1])
								next_state = O;
							else
								next_state = H;
						H : // Shift7
						
							if(LSBB[1])
								next_state = P;
							else
								next_state = I;	
								
						I : // Shift8
								next_state = R;
							
					   J : // Add1
							next_state = C;
						K : // Add2
							next_state = D;
						L : // Add3
							next_state = E;
						M : // Add4
							next_state = F;
						N : // Add5
							next_state = G;
						O : // Add6
							next_state = H;
	
					
						P : // Subtract
							next_state = I;
						Q : // Add7
							next_state = B;
						R : // halt
							if (~Run) 
								next_state = A;
				endcase
		end
		// Assign outputs based on ‘state’
		// code didn't save so had to start over but we will have state for each option on flow diagram, ex: 
		//reset, shift1, add1, shift2, shift 3, add2, subtract if M=1, and halt
		always_comb
		begin
				case (curr_state) // ASK IF WE CAN LOAD IN STATE A. AND HOW TO COUNT!
						A: // Reset
							begin
									Run_O = 1'b0;
									//this is our reset state
									Shift_En = 1'b0;
									Add_En = 1'b0;
							end
						B: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						C: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						D: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						E: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						F: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						B: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						G: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						H: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						I: // shift
							begin
									Run_O = 1'b0;
									Shift_En = 1'b1;
									Add_En = 1'b0;

							end
						J: // add
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b1;
							end
						K: // add
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b1;
							end
						L: // add
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b1;
							end
						M: // add
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b1;
							end
						N: // add
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b1;
							end
						J: // add
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b1;
							end
						O: // add
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b1;
							end
						

						P: // Subtract
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b0;
							end
							
						Q: // add
							begin
									Run_O = 1'b1;
									Shift_En = 1'b0;
									Add_En = 1'b1;
							end
							
						R: // Halt
							begin
									Run_O = 1'b0;
									Shift_En = 1'b0;
									Add_En = 1'b0;
							end
				endcase
		end
		
endmodule

 
/*module counter ( input logic Clk, Count_En,
					output logic count
);

	logic count_next;
	always_ff @ (posedge Clk)
	begin
		count <= count_next;
	end
	
	always_comb
	begin
		if (Count_En)
			count_next = count + 1;
		else if (count == 4'b1001)
			count_next = 4'b0000;
		else
			count_next = count;
	end

endmodule*/
