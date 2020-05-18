`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 08:59:50
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input Clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    //input memRead,
    output reg [31:0] readData
    );
    
    reg [31:0] memFile[0:63];
    
            
    always @(address)
        begin
            if(!memWrite) begin
                readData = memFile[address];
                $display("address is %d, and read data is %d",address,memFile[address]);
            end
        end
        
    always @(negedge Clk)
        begin
            if(memWrite) begin
                memFile[address] = writeData;
                $display("address is %d, and write data is %d",address,memFile[address]);
            end
        end
        
    //initial $readmemh("mem_data.mem", memFile);    
endmodule
