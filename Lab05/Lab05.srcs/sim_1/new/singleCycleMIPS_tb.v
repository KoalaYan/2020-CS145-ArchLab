`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/02 18:29:09
// Design Name: 
// Module Name: singleCycleMIPS_tb
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


module singleCycleMIPS_tb(
    );
    reg CLK;
    reg RET;
    Top CPU(
        .CLK(CLK),
        .RET(RET)
    );
    integer i;
    initial begin
        $readmemb("C:/koala/Lab05/Lab05.srcs/sources_1/new/inst_data.mem", CPU.instMemory.instFile);
        $readmemh("C:/koala/Lab05/Lab05.srcs/sources_1/new/mem_data.mem", CPU.memory.memFile);         
        RET = 1;
        CLK = 0;
        CPU.pc.pc_out = 0;
    end
    
    always #20 CLK = ~CLK;
    
    initial begin
        #10 RET = 0;
        #600;
        $finish;
    end
endmodule
