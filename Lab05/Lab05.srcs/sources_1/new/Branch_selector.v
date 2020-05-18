`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/01 17:56:39
// Design Name: 
// Module Name: Branch_selector
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


module Branch_selector(
    input[31:0] input1,
    input[31:0] input2,
    input signal,
    output reg[31:0] output_data
    );
    initial begin
        output_data = 0;
    end
    
    always @(input1 or input2 or signal) begin
        if(signal == 0) begin
            output_data = input1;
            $display("normal");
        end
        else begin
            output_data = input2;
            $display("branch");
        end
    end
endmodule
