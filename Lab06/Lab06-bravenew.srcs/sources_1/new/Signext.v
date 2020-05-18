`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 10:56:26
// Design Name: 
// Module Name: Signext
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

module Signext(
    input [15:0] data_in,
    output reg[31:0] data_out
    );
    always @(data_in) begin
    if(data_in[15])
        data_out = data_in | 32'hffff0000;
    else
        data_out = data_in | 32'h00000000;
    end 
endmodule
