`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 11:47:33
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input [31:0] instAddr,
    input clk,
    output [31:0] inst
    );
    reg[31:0] instFile[0:1023];
//    always @(posedge clk)
//        begin
//            inst = instFile[instAddr];
//        end
    assign inst = instFile[instAddr/4];
    //initial $readmemh("inst_data.mem", instFile);
endmodule
