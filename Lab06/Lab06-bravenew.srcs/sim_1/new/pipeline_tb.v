`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/13 16:09:29
// Design Name: 
// Module Name: pipeline_tb
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


module pipeline_tb(

    );
    reg CLK;
    reg RESET;    
    Top top(
        .clk(CLK),
        .reset(RESET)
    );
    
    initial begin
        $readmemb("C:/koala/Lab06-bravenew/Lab06-bravenew.srcs/sources_1/new/inst_data.mem", top.instMemory.instFile);
        $readmemh("C:/koala/Lab06-bravenew/Lab06-bravenew.srcs/sources_1/new/mem_data.mem", top.dataMemory.memFile);         
        top.PC = 0;
        CLK = 1;
        RESET = 1;
        #10 RESET = 0;
    end
    
    always #20 CLK = !CLK;
    
endmodule
