`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 10:54:27
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] aluCtr,
    output reg zero = 1,
    output[31:0] aluRes
);
    reg[31:0] ALURes = 0;
    always @ (input1 or input2 or aluCtr)
    begin
        $display("input data is %d and %d",input1,input2);
        if ( aluCtr == 4'b0000)//and
        begin
            ALURes = input1 & input2;
        end
        else if ( aluCtr == 4'b0001)//or
        begin
            ALURes = input1 | input2;
        end
        else if (aluCtr == 4'b0010) //add
        begin
            ALURes = input1 + input2;
        end
        else if (aluCtr == 4'b0011) //sll
        begin
            ALURes = (input2 << input1);
        end
        else if (aluCtr == 4'b0100) //srl
        begin
            ALURes = (input2 >> input1);
        end
        else if (aluCtr == 4'b0110) //sub
        begin
            ALURes = input1 - input2;            
        end
        else if ( aluCtr == 4'b0111)//slt
        begin
            ALURes = (input1<input2);            
        end
        else if ( aluCtr == 4'b0101)//jr
        begin
            ALURes = input1;            
        end
        
        
        if(!ALURes)
                zero = 1;
            else
                zero = 0;
        
        $display("alu result is %d",ALURes);
    end
    assign aluRes = ALURes;
endmodule
