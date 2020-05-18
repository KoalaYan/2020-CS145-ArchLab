`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 11:04:35
// Design Name: 
// Module Name: Mux_32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux_32(
    input[31:0] input1,
    input[31:0] input2,
    input signal,
    output reg[31:0] outdata
    );
    initial begin
        outdata = 0;
    end
    always @(signal or input1 or input2) begin
    if(signal)
        outdata = input1;
    else
        outdata = input2;
    end
    
endmodule
