`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 10:31:29
// Design Name: 
// Module Name: ALU
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


module ALU(
    input[31:0] input1,
    input[31:0] input2,
    input[3:0] aluCtr,
    
    output reg zero,
    output reg[31:0] aluRes
);
initial begin
    zero = 0;
    aluRes = 0;
end
    
always @(aluCtr or input1 or input2) begin
    case(aluCtr)
        4'b0010://add
        begin
            aluRes = input1 + input2; 
            $display("add%d,%d",input1,input2);
            end  
        4'b0110://sub
        begin
            aluRes = input1 - input2;
            $display("sub%d,%d",input1,input2);
            end
        4'b0000://and
        begin
            aluRes = input1 & input2;
            $display("and%d,%d",input1,input2);
            end
        4'b0001://or
        begin
            aluRes = input1 | input2;
            $display("or%d,%d",input1,input2);
            end
        4'b0111://slt
        begin
            aluRes = (input1<input2);
            $display("slt%d,%d",input1,input2);
            end
        4'b0011://sll
        begin
            aluRes = (input2<<input1);
            $display("sll%d,%d",input1,input2);
            end
        4'b0100://srl
        begin
            aluRes = (input2>>input1);
            $display("srl%d,%d",input1,input2);
            end
        4'b0101:
        begin
            aluRes = input1;
            end
    endcase
    
    if(aluRes==0)
        zero = 1;
    else
        zero = 0;    
    
    $display("ALU_result:%d",aluRes);
    $display("zero:%d",zero);
end
endmodule
