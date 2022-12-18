`default_nettype none
`timescale 1ns / 1ps

module bram_sdp #(
    parameter width=8, 
    parameter depth=256, 
    parameter frame=""
    ) (
    input wire logic clk_write,               // write clock (port a)
    input wire logic clk_read,                // read clock (port b)
    input wire logic we,                      // write enable (port a)
    input wire logic [14:0] addr_write,  // write address (port a)
    input wire logic [14:0] addr_read,   // read address (port b)
    input wire logic [width-1:0] data_in,     // data in (port a)
    output     logic [width-1:0] data_out     // data out (port b)
    );

    logic [width-1:0] memory [depth];

    initial begin
        if (frame != 0) begin
            $readmemh(frame, memory);
        end
    end

    // Port A: Sync Write
    always_ff @(posedge clk_write) begin
        if (we) memory[addr_write] <= data_in;
    end

    // Port B: Sync Read
    always_ff @(posedge clk_read) begin
        data_out <= memory[addr_read];
    end
endmodule