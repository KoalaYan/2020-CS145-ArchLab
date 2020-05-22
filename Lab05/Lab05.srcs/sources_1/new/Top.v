`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 10:42:59
// Design Name: 
// Module Name: Top
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


module Top(
    input CLK,
    input RET
    );
    
    wire[31:0] ADDRESS;
    wire [31:0] INST; 
    //Ctr
    wire REG_DST,
        JUMP,
        BRANCH,
        //MEM_READ,
        MEM_TO_REG,
        MEM_WRITE;
    wire[1:0] ALU_OP;
    wire ALU_SRC,
        REG_WRITE;
    //ALUCtr
    wire[3:0] ALU_CTR;  
    //Registers
    //wire[31:0] DATA;
    wire[31:0] DATA1;
    wire[31:0] DATA2;
    //ALU
    wire ZERO;
    wire[31:0] ALU_RES;
    //signalExtention
    wire[31:0] EXTDATA;
    //mux
    wire[4:0] MUX_OUT1;
    wire[31:0] MUX_OUT2;
    wire[31:0] MUX_OUT3;
    wire[31:0] MUX_OUT4;
    wire[31:0] MUX_OUT5;
    wire[31:0] MUX_OUT6;
    wire[31:0] MUX_OUT7;
    //jump addresss
    wire[31:0] JUMP_ADDRESS;
    //data memory
    wire[31:0] READ_DATA;
    //part of ALU
    wire[31:0] P_ALU_RES;
    //j or jr
    wire JUMP_C;
    //shift
    wire SHIFT;
    //jal
    wire JAL;
    assign JUMP_ADDRESS = (INST[25:0]<<2)+((ADDRESS+4) & 32'hf0000000);
    assign P_ALU_RES = (EXTDATA<<2) + (ADDRESS+4);
    
    //assign MUX_OUT1 = REG_DST ? INST[15:11] : INST[20:16];
    Rt_selector rtSelector(
        .rt(INST[20:16]),
        .rd(INST[15:11]),
        .reg_dst(REG_DST),
        .nd(MUX_OUT1)
    );
    
    //assign MUX_OUT2 = ALU_SRC ? EXTDATA : DATA2;
    Reg_Imm_selector regImmSelector(
        .regdata(DATA2),
        .imm(EXTDATA),
        .aluSrc(ALU_SRC),
        .outputdata(MUX_OUT2)
    );
    
    //assign MUX_OUT3 = (BRANCH&ZERO) ? P_ALU_RES : (ADDRESS+4);
    Branch_selector branchSelector(
    .input1(ADDRESS+4),
    .input2(P_ALU_RES),
    .signal(BRANCH&ZERO),
    .output_data(MUX_OUT3)
    );
    
    J_or_Jr jOrJr(
        .input1(JUMP_ADDRESS),
        .input2(ALU_RES),
        .j_c(JUMP_C),
        .out_data(MUX_OUT6)
    );
    
    //assign MUX_OUT4 = JUMP ? ((INST[25:0]<<2)+ (ADDRESS+4)&(32'hf0000000)): MUX_OUT3;
    Jump_selector jumpSelector(
        .input1(MUX_OUT6),
        .input2(MUX_OUT3),
        .jump(JUMP),
        .to_pc(MUX_OUT4)
    );
    
    //assign MUX_OUT5 = MEM_TO_REG ? READ_DATA : ALU_RES;
    Mem_Reg_selector memRegSelector(
        .mem_data(READ_DATA),
        .reg_data(ALU_RES),
        .mem_to_reg(MEM_TO_REG),
        .data_out(MUX_OUT5)
    );
    
    Shift_selector shiftSelector(
        .data(DATA1),
        .shift_data(INST[10:6]),
        .shift(SHIFT),
        .outputdata(MUX_OUT7)
    );
    
    
    InstMemory instMemory(
        .instAddr(ADDRESS),
        .inst(INST)
    );
    
       
    Ctr mainCtr(
        .opCode(INST[31:26]),
        .regDst(REG_DST),
        .jump(JUMP),
        .branch(BRANCH),
        //.memRead(MEM_READ),
        .memToReg(MEM_TO_REG),
        //.aluOp(ALU_OP),
        .memWrite(MEM_WRITE),
        .aluSrc(ALU_SRC),
        .regWrite(REG_WRITE),
        .Funct(INST[5:0]),
        .aluCtrOut(ALU_CTR),
        .shift(SHIFT),
        .jump_mux(JUMP_C),
        .jal(JAL)
    );
    
    Registers register(
        .readReg1(INST[25:21]),
        .readReg2(INST[20:16]),
        .writeReg(MUX_OUT1),
        .writeData(MUX_OUT5),
        .regWrite(REG_WRITE),
        .jal(JAL),
        .pcp(ADDRESS+4),
        .Ret(RET),
        .Clk(CLK),
        .readData1(DATA1),
        .readData2(DATA2)
    );
    
    
    ALU alu(
        .input1(MUX_OUT7),
        .input2(MUX_OUT2),
        .zero(ZERO),
        .aluCtr(ALU_CTR),
        .aluRes(ALU_RES)
    );
    
    
    signext Signext(
        .inst(INST[15:0]),
        .data(EXTDATA)
    );
    
    
    dataMemory memory(
        .Clk(CLK),
        .address(ALU_RES),
        .writeData(DATA2),
        .memWrite(MEM_WRITE),
        //.memRead(MEM_READ),
        .readData(READ_DATA)
    );
   
   
    PC pc(
        .pc_in(MUX_OUT4),
        .clk(CLK),
        .ret(RET),
        .pc_out(ADDRESS)
    );
endmodule
