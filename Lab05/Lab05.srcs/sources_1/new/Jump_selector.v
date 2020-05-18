`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/01 17:28:21
// Design Name: 
// Module Name: Jump_selector
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


module Jump_selector(
    input[31:0] input1,
    input[31:0] input2,
    input jump,
    output reg[31:0] to_pc
    );
    initial begin
        to_pc = 0;
    end
    
    always @(input1 or input2 or jump) begin
        if(jump == 0) begin
            to_pc = input2;
        end
        else begin
            to_pc = input1;
        end
        $display("input1 is%d and input2 is%d, we choose %d",input1,input2,to_pc);
    end
endmodule
