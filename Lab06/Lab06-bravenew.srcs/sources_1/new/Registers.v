`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 10:48:30
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
    input clk,
    input reset,
    input[4:0] readReg1,
    input[4:0] readReg2,
    input[4:0] writeReg,
    input[31:0] writeData,
    input regWrite,
    input jal,
    input[31:0] pcp,
    
    output reg[31:0] readData1,
    output reg[31:0] readData2
    );
    reg[31:0] regFile[0:31];
    integer i;
    always @(*) begin
        readData1 = regFile[readReg1];
        readData2 = regFile[readReg2];
        $display("reg%dread_data1:%d\nreg%dread_data2:%d",readReg1,readData1,readReg2,readData2);
    end
    
    always @(negedge clk) begin
        if(regWrite) begin
            if(jal)
                regFile[31] <= pcp;
            else begin
            regFile[writeReg] <= writeData;
            $display("reg_write_data:%d",writeData);
            end
        end
    end
    
    always @(reset) begin
        for(i=0;i<32;i=i+1)
            regFile[i] = 0;
    end
endmodule
