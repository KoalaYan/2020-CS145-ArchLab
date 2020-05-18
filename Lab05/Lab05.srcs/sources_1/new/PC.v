`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 13:58:53
// Design Name: 
// Module Name: PC
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


module PC(
    input [31:0] pc_in,
    input clk,
    input ret,
    output reg [31:0] pc_out
    );
    initial pc_out = 32'b0;
    always @(posedge clk or ret) begin
        if(!ret) begin
            pc_out = pc_in;
            $display("PC is %d\n",pc_in);
        end
        else
            pc_out = 0;
    end
endmodule
