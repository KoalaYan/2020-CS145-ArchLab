`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 11:03:17
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
    output reg [31:0] inst
    );
    reg[31:0] instFile[0:1023];
    always @(instAddr) begin
        inst = instFile[instAddr/4];
        $display("instAddr:%d",instAddr);
    end
endmodule
