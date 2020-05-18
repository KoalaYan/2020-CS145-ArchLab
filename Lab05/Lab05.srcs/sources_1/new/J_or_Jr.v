`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/02 08:46:34
// Design Name: 
// Module Name: J_or_Jr
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


module J_or_Jr(
    input[31:0] input1,
    input[31:0] input2,
    input j_c,
    output reg[31:0] out_data
    );
    initial begin
        out_data = 0;
    end
    
    always @(input1 or input2 or j_c) begin
        if(j_c == 1) begin
            out_data = input2;
            $display("jr address is %d",out_data);
        end
        else begin
            out_data = input1;
            $display("j address is%d",out_data);
        end
        
    end
endmodule
