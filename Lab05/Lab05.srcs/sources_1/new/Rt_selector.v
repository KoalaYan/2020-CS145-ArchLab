`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/01 16:40:04
// Design Name: 
// Module Name: Rt_selector
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


module Rt_selector(
    input[4:0] rt,
    input[4:0] rd,
    input reg_dst,
    output reg[4:0] nd
    );
    initial begin
        nd = 0;
    end
    
    always @(rt or rd or reg_dst) begin
        if(reg_dst == 0) begin
            nd = rt;
        end
        else begin
            nd = rd;
        end
    end
endmodule
