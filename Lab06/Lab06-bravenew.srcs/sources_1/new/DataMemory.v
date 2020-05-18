`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 10:43:16
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input clk,
    input[31:0] address,
    input[31:0] writeData,
    input memWrite,
    input memRead,
    output reg[31:0] readData
    );
    
    reg[31:0] memFile[0:31];
    
    always @(address or memRead) begin
        if(memRead) begin
            readData = memFile[address];
            $display("mem%d read_data:%d",address,readData);
        end
        else
            readData = 0;
    end
    
    always @(negedge clk) begin
        if(memWrite) begin
            memFile[address] <= writeData;
            $display("mem_write_data:%d",writeData);
        end
    end
endmodule
