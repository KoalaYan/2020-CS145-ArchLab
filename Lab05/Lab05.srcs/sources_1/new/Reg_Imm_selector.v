`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/01 09:13:03
// Design Name: 
// Module Name: Reg_Imm_selector
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


module Reg_Imm_selector(
    input[31:0] regdata,
    input[31:0] imm,
    input aluSrc,
    output reg[31:0] outputdata
    );
    
    initial begin
        outputdata = 0;
    end
    
    always @(aluSrc or regdata or imm) begin
        if(aluSrc == 0) begin
            outputdata = regdata;
            $display("Reg_Imm_outdata is regdata%d",outputdata);
        end
        else begin
            outputdata = imm;
            $display("Reg_Imm_outdata is imm%d",outputdata);
        end
        
    end
endmodule
