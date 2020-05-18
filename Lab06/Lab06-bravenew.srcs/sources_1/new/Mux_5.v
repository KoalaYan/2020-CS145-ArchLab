`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 11:07:26
// Design Name: 
// Module Name: Mux_5
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


module Mux_5(
    input[4:0] input1,
    input[4:0] input2,
    input signal,
    output reg[4:0] outdata
    );
    initial begin
        outdata = 0;
    end
    always @(signal or input1 or input2) begin
    if(signal)
        outdata = input1;
    else
        outdata = input2;
    $display("mux_reg:%d",outdata);
    end
endmodule
