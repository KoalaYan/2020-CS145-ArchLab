`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/03 11:21:35
// Design Name: 
// Module Name: Shift_selector
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


module Shift_selector(
    input[31:0] data,
    input[4:0] shift_data,
    input shift,
    output reg[31:0] outputdata
    );
    initial begin
        outputdata = 0;
    end
    
    always @(shift or data or shift_data) begin
        if(shift == 0) begin
            outputdata = data;
        end
        else begin
            outputdata = shift_data;
        end
        
    end
endmodule
