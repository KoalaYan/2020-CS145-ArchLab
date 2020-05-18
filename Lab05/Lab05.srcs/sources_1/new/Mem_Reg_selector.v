`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/01 09:21:55
// Design Name: 
// Module Name: Mem_Reg_selector
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


module Mem_Reg_selector(
    input[31:0] mem_data,
    input[31:0] reg_data,
    input mem_to_reg,
    output reg[31:0] data_out
    );
    
    initial begin
        data_out = 0;
    end
    
    always @(mem_data, reg_data, mem_to_reg) begin
        if(mem_to_reg == 0) begin
            data_out = reg_data;
        end
        else begin
            data_out = mem_data;
        end
    end
    
endmodule
