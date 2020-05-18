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
    output reg [31:0] aluRes = 0
);
    always @ (input1 or input2 or aluCtr)
    begin
        if (aluCtr == 4'b0010) //add
        begin
            aluRes = input1 + input2;
        end
        else if (aluCtr == 4'b0110) //sub
        begin
            aluRes = input1 - input2;           
        end
        else if ( aluCtr == 4'b0000)
        begin
            aluRes = input1 & input2;
        end
        else if ( aluCtr == 4'b0001)
        begin
            aluRes = input1 | input2;
        end
        else if ( aluCtr == 4'b0111)
        begin
            aluRes = (input1<input2);
        end
        else if ( aluCtr == 4'b1100)
        begin
            aluRes = ~(input1 | input2);
        end
        
         if(aluRes == 0)
              zero = 1;
          else
              zero = 0;
    end
endmodule
