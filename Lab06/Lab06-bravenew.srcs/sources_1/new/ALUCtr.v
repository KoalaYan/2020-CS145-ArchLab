`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 10:20:51
// Design Name: 
// Module Name: ALUCtr
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


module ALUCtr(
    input[5:0] funct,
    input[1:0] aluOp,
    input[5:0] opCode,
    output reg shamt,
    output reg [3:0] aluCtrOut
    );
    always @({aluOp,funct} or opCode) begin
        shamt = 0;
        casex({aluOp,funct})
            //add 2
            8'b10100000: aluCtrOut = 4'b0010;
//            8'b00001000: aluCtrOut = 4'b0010;
//            8'b00100011: aluCtrOut = 4'b0010;
//            8'b00101011: aluCtrOut = 4'b0010;
//            8'b00000010: aluCtrOut = 4'b0010;
            //sub 6
            8'b10100010: aluCtrOut = 4'b0110;
            //8'b01000100: aluCtrOut = 4'b0110;
            //and 0
            8'b10100100: aluCtrOut = 4'b0000;
            //8'b00001100: aluCtrOut = 4'b0000;
            //or 1
            8'b10100101: aluCtrOut = 4'b0001;
            //8'b00001101: aluCtrOut = 4'b0001;
            //slt 7
            8'b10101010: aluCtrOut = 4'b0111;
            //sll 3
            8'b10000000: begin
                aluCtrOut = 4'b0011;
                shamt = 1;
                end
            //srl 4
            8'b10000010: begin
                aluCtrOut = 4'b0100;
                shamt = 1;
                end
            //jr 5    
            8'b10001000: aluCtrOut = 4'b0101;            
        endcase
        
        casex(opCode)
            //add
            6'b001000: aluCtrOut = 4'b0010;
            6'b100011: aluCtrOut = 4'b0010;
            6'b101011: aluCtrOut = 4'b0010;
            6'b000010: aluCtrOut = 4'b0010;
            //sub
            6'b000100: aluCtrOut = 4'b0110;
            //and
            6'b001100: aluCtrOut = 4'b0000;
            //or
            6'b001101: aluCtrOut = 4'b0001;            
        endcase
        
        
        case(aluCtrOut)
            4'b0010: $display("add");
            4'b0110: $display("sub");
            4'b0000: $display("and");
            4'b0001: $display("or");
            4'b0111: $display("slt");
            4'b0011: $display("sll");
            4'b0100: $display("srl");
            4'b0101: $display("jr");
        endcase
    end
endmodule
