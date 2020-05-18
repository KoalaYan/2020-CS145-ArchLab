`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 10:01:45
// Design Name: 
// Module Name: ALUCtr_tb
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


module ALUCtr_tb(

    );
    reg [1:0] ALUOp;
    reg [5:0] Funct;
    wire [3:0] aluCtrOut;
    
    ALUCtr u0(
        .ALUOp(ALUOp),
        .Funct(Funct),
        .aluCtrOut(aluCtrOut)
    );
    
    initial begin
        //Initialize Inputs
        ALUOp = 0;
        Funct = 0;
        //wait 100 ns for global reset to finish
        #40;
        
        #60 ALUOp = 2'b00;
        Funct = 6'bxxxxxx;//0010
        
        #60 ALUOp = 2'b01;
        Funct = 6'bxxxxxx;//0110
        
        #60 ALUOp = 2'b1x;
        Funct = 6'bxx0000;//0010
        
        #60 ALUOp = 2'b1x;
        Funct = 6'bxx0010;//0110
        
        #60 ALUOp = 2'b1x;
        Funct = 6'bxx0100;//0000    
        
        #60 ALUOp = 2'b1x;
        Funct = 6'bxx0101;//0001   
        
        #60 ALUOp = 2'b1x;
        Funct = 6'bxx1010;//0111    
    end
endmodule
