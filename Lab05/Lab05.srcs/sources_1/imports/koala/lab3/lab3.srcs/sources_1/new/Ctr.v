`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 08:25:02
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] opCode,
    output regDst,
    output aluSrc,
    output memToReg,
    output regWrite,
    //output memRead,
    output memWrite,
    output branch,
    output jump,
    output jump_mux,
    output shift,
    
    //input [1:0] ALUOp,
    input [5:0] Funct,
    output[3:0] aluCtrOut
    );
    
    reg RegDst;
    reg ALUSrc;
    reg MemToReg;
    reg RegWrite;
    //reg MemRead;
    reg MemWrite;
    reg Branch;
    //reg [1:0] ALUOp;
    reg Jump;
    reg JumpMux;
    reg Shift;
    reg[3:0] ALUCtrOut;
    
    always@(*)
    begin
        Shift = 0;
        case(opCode)
        6'b000000: //R type
        begin
            RegDst = 1;
            ALUSrc = 0;
            MemToReg = 0;
            RegWrite = 1;
            //MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            //ALUOp = 2'b10;
            Jump = 0;
            JumpMux = 0;
            case (Funct)
                6'b100000: begin ALUCtrOut = 4'b0010;//add 2
                $display("add\n");end
                6'b100010: begin ALUCtrOut = 4'b0110;//sub 6
                $display("sub\n");end
                6'b100100: begin ALUCtrOut = 4'b0000;//and 0
                $display("and\n");end
                6'b100101: begin ALUCtrOut = 4'b0001;//or 1
                $display("or\n");end
                6'b101010: begin ALUCtrOut = 4'b0111;//slt 7
                $display("slt\n");end
                6'b000000: begin ALUCtrOut = 4'b0011;//sll 3
                Shift = 1;
                $display("sll\n");end
                6'b000010: begin ALUCtrOut = 4'b0100;//srl 4
                Shift = 1;
                $display("srl\n");end
                6'b001000: begin
                    ALUCtrOut = 4'b0101;//jr 5
                    RegDst = 0;
                    ALUSrc = 0;
                    MemToReg = 0;
                    RegWrite = 0;
                    //MemRead = 0;
                    MemWrite = 0;
                    Branch = 0;
                    Jump = 1;
                    JumpMux = 1;
                    $display("jr\n");
                end        
            endcase
        end
        //I-type
        6'b001000: //addi        
        begin
            RegDst = 0;
            ALUSrc = 1;
            MemToReg = 0;
            RegWrite = 1;
            //MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            //ALUOp = 2'b00;
            Jump = 0;
            JumpMux = 0;
            ALUCtrOut = 4'b0010;//add 2
            $display("addi\n");
        end     
        
        6'b001100: //andi
        begin
            RegDst = 0;
            ALUSrc = 1;
            MemToReg = 0;
            RegWrite = 1;
            //MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            //ALUOp = 2'b00;
            Jump = 0;
            JumpMux = 0;
            ALUCtrOut = 4'b0000;//and 0
            $display("andi\n");
        end    
        
        6'b001101: //ori
        begin
            RegDst = 0;
            ALUSrc = 1;
            MemToReg = 0;
            RegWrite = 1;
            //MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            //ALUOp = 2'b00;
            Jump = 0;
            JumpMux = 0;
            ALUCtrOut = 4'b0001;//or 1
            $display("ori\n");
        end
        
        6'b100011: //lw
        begin
            RegDst = 0;
            ALUSrc = 1;
            MemToReg = 1;
            RegWrite = 1;
            //MemRead = 1;
            MemWrite = 0;
            Branch = 0;
            //ALUOp = 2'b00;
            Jump = 0;
            JumpMux = 0;
            ALUCtrOut = 4'b0010;//add 2
            $display("lw\n");
        end
        
        6'b101011: //sw
        begin
            RegDst = 0;
            ALUSrc = 1;
            MemToReg = 0;
            RegWrite = 0;
            //MemRead = 0;
            MemWrite = 1;
            Branch = 0;
            //ALUOp = 2'b00;
            Jump = 0;
            JumpMux = 0;
            ALUCtrOut = 4'b0010;//add 2
            $display("sw\n");
        end
        
        6'b000100: //beq
        begin
            RegDst = 0;
            ALUSrc = 0;
            MemToReg = 0;
            RegWrite = 0;
            //MemRead = 0;
            MemWrite = 0;
            Branch = 1;
            //ALUOp = 2'b01;
            Jump = 0;
            JumpMux = 0;
            ALUCtrOut = 4'b0110;//sub 6
            $display("beq\n");
        end
        
        6'b000010: //jump
        begin
            RegDst = 0;
            ALUSrc = 0;
            MemToReg = 0;
            RegWrite = 0;
            //MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            //ALUOp = 2'b00;
            Jump = 1;
            JumpMux = 0;
            $display("jump\n");
            ALUCtrOut = 4'b0010;
        end
        
        default:
        begin
            RegDst = 0;
            ALUSrc = 0;
            MemToReg = 0;
            RegWrite = 0;
            //MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            //ALUOp = 2'b00;
            Jump = 0;
            JumpMux = 0;
            ALUCtrOut = 4'b0010;//add 2
            Shift = 0;
            $display("default\n");
        end
    endcase
    end
    assign regDst = RegDst;
    assign aluSrc = ALUSrc;
    assign memToReg = MemToReg;
    assign regWrite = RegWrite;
    //assign memRead = MemRead;
    assign memWrite = MemWrite;
    assign branch = Branch;
    //assign aluOp = ALUOp;
    assign jump = Jump;
    assign jump_mux = JumpMux;
    assign aluCtrOut = ALUCtrOut;
    assign shift = Shift;
endmodule
