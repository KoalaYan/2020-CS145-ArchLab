`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 11:15:11
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb(

    );
    reg [31:0] input1;
    reg [31:0] input2;
    reg [3:0] aluCtr;
    wire zero;
    wire [31:0] aluRes;
    
    ALU u0(
        .input1(input1),
        .input2(input2),
        .aluCtr(aluCtr),
        .zero(zero),
        .aluRes(aluRes)
    );
    
    initial begin
        input1 = 0;
        input2 = 0;
        aluCtr = 4'b0000;
        #100;
        
        input1 = 15;
        input2 = 10;
        #100;
        
        aluCtr = 4'b0001;
        #100;
        
        aluCtr = 4'b0010;
        #100;
        
        aluCtr = 4'b0110;
        #100;
        
        input1 = 10;
        input2 = 15;
        #100;
        
        input1 = 15;
        input2 = 10;
        aluCtr = 4'b0111;
        #100;
        
        input1 = 10;
        input2 = 15;
        #100;
        
        input1 = 32'b00000000000000000000000000000001;
        input2 = 32'b00000000000000000000000000000001;
        aluCtr = 4'b1100;
        #100;
        
        input1 = 32'b00000000000000000000000000010000;
        #100;
    end
endmodule
