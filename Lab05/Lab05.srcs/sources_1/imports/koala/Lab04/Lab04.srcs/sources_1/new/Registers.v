`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 07:52:37
// Design Name: 
// Module Name: Registers
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


module Registers(
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    input Clk,
    input Ret,
    input jal,
    input[31:0] pcp,
    output [31:0] readData1,
    output [31:0] readData2
    );
    reg [31:0] regFile[31:0];
    integer i;
    reg[31:0] ReadData1;
    reg[31:0] ReadData2;
    
    always @(posedge Clk or Ret)
        begin
        if(Ret) begin
            for(i = 0;i <= 31;i = i+1) begin
                regFile[i] = 32'h00000000;
            end
        end
        else if(regWrite) begin
            if(jal)
                regFile[31] = pcp;
            else begin
            regFile[writeReg] = writeData;
            $display("Register write data is%d in%d",writeData,writeReg); end
            end
        end
        
    always @(readReg1 or readReg2) begin
        ReadData1 = regFile[readReg1];
        ReadData2 = regFile[readReg2];
        $display("reg_readData is%d in%d and%d in %d",ReadData1,readReg1,ReadData2,readReg2);
    end   
    assign readData1 = ReadData1;
    assign readData2 = ReadData2;
endmodule
