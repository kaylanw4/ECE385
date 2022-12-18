//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Lab 5 Given Code - SLC-3 top-level (Physical RAM)
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//------------------------------------------------------------------------------


module slc3(
	input logic [9:0] SW,
	input logic	Clk, Reset, Run, Continue,
	output logic [9:0] LED,
	input logic [15:0] Data_from_SRAM,
	output logic OE, WE,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3,
	output logic [15:0] ADDR,
	output logic [15:0] Data_to_SRAM
);


// An array of 4-bit wires to connect the hex_drivers efficiently to wherever we want
// For Lab 1, they will direclty be connected to the IR register through an always_comb circuit
// For Lab 2, they will be patched into the MEM2IO module so that Memory-mapped IO can take place
logic [3:0] hex_4[3:0]; 

HexDriver hex_drivers[3:0] (hex_4, {HEX3, HEX2, HEX1, HEX0});
// This works thanks to http://stackoverflow.com/questions/1378159/verilog-can-we-have-an-array-of-custom-modules




// Internal connections
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic SR2MUX, ADDR1MUX, MARMUX;
logic BEN, MIO_EN, DRMUX, SR1MUX;
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic [2:0] SR1, SR2, DR;
logic [15:0] MDR_In;
logic [15:0] MAR, MDR, IR, PC, BUS, PC_Out, MDR_Out, MAR_Sum;
logic [15:0] ADDR1_value, ADDR2_value, ADDR_sum;
logic n_out, z_out, p_out;
logic n_value, z_value, p_value;
logic BEN_value;
logic [15:0] regfile [8];
logic [15:0] Out1, Out2, DR_Out, SR2_ALU, ALU_Out;

// Connect MAR to ADDR, which is also connected as an input into MEM2IO
//	MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
//	input into MDR)
assign ADDR = MAR; 
assign MIO_EN = OE;
assign LED = IR[9:0];
assign ADDR_sum = ADDR1_value + ADDR2_value;
// Connect everything to the data path (you have to figure out this part)
// datapath d0 (.*);

// 4 input mux in place of tristate buffers
always_comb
begin
	if(GateMARMUX)
		BUS = ADDR_sum; 
	else if(GatePC)
		BUS = PC_Out;
	else if(GateALU)
		BUS = ALU_Out;   
	else if(GateMDR)
		BUS = MDR_Out;
	else
		BUS = 'x;
end

// PCMUX

always_comb
case (PCMUX)
	2'b00: PC = PC_Out + 1;
	2'b01: PC = ADDR_sum;
	2'b10: PC = BUS;
	default: PC = 0; //Change this week 2
endcase

// MDRMUX
always_comb
begin
	if(MIO_EN)
		MDR = MDR_In;
	else
		MDR = BUS;
end

//registers for PC, MAR, MDR, IR
reg_16 PCreg (.*, .Reset(Reset), .Load(LD_PC), .D(PC), .Data_Out(PC_Out));
reg_16 MARreg (.*, .Reset(Reset), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
reg_16 MDRreg (.*, .Reset(Reset), .Load(LD_MDR), .D(MDR), .Data_Out(MDR_Out));
reg_16 IRreg (.*, .Reset(Reset), .Load(LD_IR), .D(BUS), .Data_Out(IR));

//registers for nzp


always_comb
	begin
		if (BUS[15])
			n_value = 1;
		else
			n_value = 0;
		if (BUS == 0)
			z_value = 1;
		else 
			z_value = 0;
		if (n_value | z_value)
			p_value = 0;
		else
			p_value = 1;
	end
	
reg_1 n (.*, .Reset(Reset), .Load(LD_CC), .D(n_value), .Data_Out(n_out));
reg_1 z (.*, .Reset(Reset), .Load(LD_CC), .D(z_value), .Data_Out(z_out));
reg_1 p (.*, .Reset(Reset), .Load(LD_CC), .D(p_value), .Data_Out(p_out));

//BEN logic

always_comb
	begin
		if((IR[11] & n_out) | (IR[10] & z_out) | (IR[9] & p_out))
			BEN_value = 1;
		else 
			BEN_value = 0;
	end
	
reg_1 BEN_reg (.*, .Reset(Reset), .Load(LD_BEN), .D(BEN_value), .Data_Out(BEN));


//REG FILE


always_comb begin
	Out1 = regfile[SR1];
	Out2 = regfile[SR2];
end

always_ff @ (posedge Clk)
begin
	if(LD_REG)
		regfile[DR] <= BUS;
end   



//SR1 mux
always_comb
begin
	if(SR1MUX)
		SR1 = IR[11:9];
	else
		SR1 = IR[8:6];
end

//DR mux
always_comb
begin
	if(DRMUX)
		DR = 3'b111;
	else
		DR = IR[11:9];
end

//reg file SR2MUX 

assign SR2 = IR[2:0];



//ALU

//sign extensions
logic [15:0] SEXT_IR_5, SEXT_IR_6, SEXT_IR_9, SEXT_IR_11;

assign SEXT_IR_5 = {{11{IR[4]}}, IR[4:0]};
assign SEXT_IR_6 = {{10{IR[5]}}, IR[5:0]};
assign SEXT_IR_9 = {{7{IR[8]}}, IR[8:0]};
assign SEXT_IR_11 = {{5{IR[10]}}, IR[10:0]};

//SR2 MUX
always_comb
begin
	if(SR2MUX)
		SR2_ALU = SEXT_IR_5;
	else
		SR2_ALU = Out2;
end

// ALU mux
logic [15:0] ADD_Out, AND_Out;

assign ADD_Out = Out1 + SR2_ALU;
assign AND_Out = Out1 & SR2_ALU;

always_comb
case (ALUK)
	2'b11: ALU_Out = ADD_Out;
	2'b01: ALU_Out = AND_Out;
	2'b10: ALU_Out = ~Out1;
	default: ALU_Out = Out1;
endcase

//ADDR1MUX

always_comb
	begin
		if(ADDR1MUX)
			ADDR1_value = Out1;
		else	
			ADDR1_value = PC_Out;
	end

//ADDR2MUX
always_comb
case (ADDR2MUX)
	2'b00 : ADDR2_value = 0;
	2'b01 : ADDR2_value = SEXT_IR_6;
	2'b10 : ADDR2_value = SEXT_IR_9;
	default : ADDR2_value = SEXT_IR_11;
endcase

//adder for ADDR1 and ADDR2


/*reg_16 R0 (.*, .Reset(Reset), .Load(LD_PC), .D(PC), .Data_Out(PC_Out));
reg_16 R1 (.*, .Reset(Reset), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
reg_16 R2 (.*, .Reset(Reset), .Load(LD_MDR), .D(MDR), .Data_Out(MDR_Out));
reg_16 R3 (.*, .Reset(Reset), .Load(LD_IR), .D(BUS), .Data_Out(IR));
reg_16 R4 (.*, .Reset(Reset), .Load(LD_PC), .D(PC), .Data_Out(PC_Out));
reg_16 R5 (.*, .Reset(Reset), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
reg_16 R6 (.*, .Reset(Reset), .Load(LD_MDR), .D(MDR), .Data_Out(MDR_Out));
reg_16 R7 (.*, .Reset(Reset), .Load(LD_IR), .D(BUS), .Data_Out(IR));

assign hex_4[3] = IR[15:12];
assign hex_4[2] = IR[11:8];
assign hex_4[1] = IR[7:4];
assign hex_4[0] = IR[3:0];*/


// Our SRAM and I/O controller (note, this plugs into MDR/MAR)

Mem2IO memory_subsystem(
    .*, .Reset(Reset), .ADDR(ADDR), .Switches(SW),
    .HEX0(hex_4[0][3:0]), .HEX1(hex_4[1][3:0]), 
	 .HEX2(hex_4[2][3:0]), .HEX3(hex_4[3][3:0]),
    .Data_from_CPU(MDR_Out), .Data_to_CPU(MDR_In),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);

// State machine, you need to fill in the code here as well
ISDU state_controller(
	.*, .Reset(Reset), .Run(Run), .Continue(Continue),
	.Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]), 
   .Mem_OE(OE), .Mem_WE(WE), .BEN(BEN), 
	.ALUK(ALUK),
	.GatePC(GatePC), .GateMDR(GateMDR), .GateALU(GateALU), .GateMARMUX(GateMARMUX), 
	.LD_PC(LD_PC), .LD_MDR(LD_MDR), .LD_IR(LD_IR), .LD_CC(LD_CC), .LD_REG(LD_REG), .LD_MAR(LD_MAR), .LD_BEN(LD_BEN),
	.DRMUX(DRMUX), .SR1MUX(SR1MUX), .SR2MUX(SR2MUX), .PCMUX(PCMUX), .ADDR1MUX(ADDR1MUX), .ADDR2MUX(ADDR2MUX)
);

// SRAM WE register
//logic SRAM_WE_In, SRAM_WE;
//// SRAM WE synchronizer
//always_ff @(posedge Clk or posedge Reset_ah)
//begin
//	if (Reset_ah) SRAM_WE <= 1'b1; //resets to 1
//	else 
//		SRAM_WE <= SRAM_WE_In;
//end

	
endmodule


module reg_16 ( input						Clk, Reset, Load,
					input						[15:0] D,
					output logic 			[15:0] Data_Out);
					
		always_ff @ (posedge Clk or posedge Reset)
		begin
				// Setting the output Q[15..0] of the register to zeros as Reset is pressed
				if(Reset)
					Data_Out <= 16'b0000000000000000;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else if(Load)
					Data_Out <= D;
		end
		
endmodule
module reg_1 ( input						Clk, Reset, Load,
					input						D,
					output logic 			Data_Out);
					
		always_ff @ (posedge Clk or posedge Reset)
		begin
				// Setting the output Q[15..0] of the register to zeros as Reset is pressed
				if(Reset)
					Data_Out <= 1'b0;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else if(Load)
					Data_Out <= D;
		end
		
endmodule




