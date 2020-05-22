`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 11:08:41
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
    input clk,
    input reset
    );
    
    //segment registers
    //IF2ID
    reg[31:0] IF_ID_pcp;
    reg[31:0] IF_ID_inst;
    wire[4:0] IF_ID_inst_rs = IF_ID_inst[25:21];
    wire[4:0] IF_ID_inst_rt = IF_ID_inst[20:16];
    wire[4:0] IF_ID_inst_rd = IF_ID_inst[15:11];
    //contro signal branch
    wire BRANCH;  
    wire JUMP;
    wire JR;
    wire JAL;
    wire ZERO;
      
    //ID2EX
    reg[31:0] ID_EX_branchshift;
    reg[31:0] ID_EX_inst;
    reg[31:0] ID_EX_shamt;
    reg[8:0] ID_EX_ctr;
    reg[31:0] ID_EX_imm;
    reg[31:0] ID_EX_readData1;
    reg[31:0] ID_EX_readData2;
    reg[4:0] ID_EX_inst_rs;
    reg[4:0] ID_EX_inst_rt;
    reg[4:0] ID_EX_inst_rd;
    reg[31:0] ID_EX_pcp;
    reg ID_EX_JR;
    //control signal
    wire ID_EX_ALUSRC = ID_EX_ctr[8];
    wire[1:0] ID_EX_aluOp = ID_EX_ctr[7:6];
    wire ID_EX_REGDST = ID_EX_ctr[5];
    wire ID_EX_MEMREAD = ID_EX_ctr[4];
    wire ID_EX_MEMWRITE = ID_EX_ctr[3];
    wire ID_EX_BRANCH = ID_EX_ctr[2];
    wire ID_EX_MEMTOREG = ID_EX_ctr[1];
    wire ID_EX_REGWRITE = ID_EX_ctr[0];
    
    //EX2MEM
    reg[31:0] EX_MEM_aluRes;
    reg[31:0] EX_MEM_writeData;
    reg[4:0] EX_MEM_regd;
    reg[4:0] EX_MEM_ctr;
    //reg EX_MEM_zero;
    //control signal
    wire EX_MEM_MEMREAD = EX_MEM_ctr[4];
    wire EX_MEM_MEMWRITE = EX_MEM_ctr[3];
    wire EX_MEM_BRANCH = EX_MEM_ctr[2];
    wire EX_MEM_MEMTOREG = EX_MEM_ctr[1];
    wire EX_MEM_REGWRITE = EX_MEM_ctr[0];
    
    //MEM2WB
    reg[31:0] MEM_WB_aluRes;
    reg[31:0] MEM_WB_memData;
    reg[4:0] MEM_WB_regd;
    reg[1:0] MEM_WB_ctr;
    //control signal
    wire MEM_WB_MEMTOREG = MEM_WB_ctr[1];
    wire MEM_WB_REGWRITE = MEM_WB_ctr[0];
    
    //hazard detect
    wire STALL = ID_EX_MEMREAD & (ID_EX_inst_rt == IF_ID_inst_rs | ID_EX_inst_rt == IF_ID_inst_rt);
    //reg stall;
    //instancialize
    
    //IF
    reg[31:0] PC;
    wire[31:0] PCP = PC+4; //pc+4
    wire[31:0] BRANCH_ADDRESS;
    wire[31:0] JUMP_ADDRESS;
    wire[31:0] JR_ADDRESS;
    wire[31:0] NEXT_PC = BRANCH ? BRANCH_ADDRESS : JUMP ? JUMP_ADDRESS : JR ? JR_ADDRESS : PCP;
    wire[31:0] IF_INST;
    
    InstMemory instMemory(
        .instAddr(PC),
        .inst(IF_INST)
    );
    
    //ID
    wire[10:0] CTR_OUT;
    Ctr mainCtr(
        .opCode(IF_ID_inst[31:26]),
        .funct(IF_ID_inst[5:0]),
        .regDst(CTR_OUT[5]),
        .aluSrc(CTR_OUT[8]),
        .memToReg(CTR_OUT[1]),
        .regWrite(CTR_OUT[0]),
        .memRead(CTR_OUT[4]),
        .memWrite(CTR_OUT[3]),
        .branch(CTR_OUT[2]),
        .aluOp(CTR_OUT[7:6]),
        .jump(CTR_OUT[9]),
        .jr(CTR_OUT[10]),
        .jal(JAL)
    );
    
    //signal extend
    wire[31:0] IMM_SIGNEXT;
    Signext signext(
        .data_in(IF_ID_inst[15:0]),
        .data_out(IMM_SIGNEXT)
    );
        
    //register
    wire[31:0] REG_READ_DATA1;
    wire[31:0] REG_READ_DATA2;
    wire[31:0] REG_WRITE_DATA;
    Registers registers(
        .clk(clk),
        .reset(reset),
        .readReg1(IF_ID_inst_rs),
        .readReg2(IF_ID_inst_rt),
        .writeReg(MEM_WB_regd),
        .writeData(REG_WRITE_DATA),
        .regWrite(MEM_WB_REGWRITE),
        .readData1(REG_READ_DATA1),
        .readData2(REG_READ_DATA2),
        .jal(JAL),
        .pcp(IF_ID_pcp)
    );
    
    //branch
    wire[31:0] IMM_SIGNEXT_SHIFT = IMM_SIGNEXT<<2;     
    
    assign BRANCH_ADDRESS = ID_EX_pcp + ID_EX_branchshift;
    //jump    
    assign JUMP = CTR_OUT[9];
    assign JUMP_ADDRESS = (IF_ID_inst[25:0]<<2)+(IF_ID_pcp & 32'hf0000000);
    //jr    
    assign JR = ID_EX_JR;
    
    
    
    //forwaring
    wire FORWARD_EX_A = (EX_MEM_REGWRITE & EX_MEM_regd==ID_EX_inst_rs & (EX_MEM_regd!=0));  //input1 of alu(aluRes/regWriteData/readData1)
    wire FORWARD_EX_B = (EX_MEM_REGWRITE & EX_MEM_regd==ID_EX_inst_rt & (EX_MEM_regd!=0));  //input2 of alu(immSignext/regWriteDats/readData2)
    wire FORWARD_MEM_A = (MEM_WB_REGWRITE & MEM_WB_regd==ID_EX_inst_rs & MEM_WB_regd!=0)  //A and B memWriteData
        & !(EX_MEM_REGWRITE & EX_MEM_regd==ID_EX_inst_rs & EX_MEM_regd!=0);
    wire FORWARD_MEM_B = (MEM_WB_REGWRITE & MEM_WB_regd==ID_EX_inst_rt & (MEM_WB_regd!=0)) //
        & !(EX_MEM_REGWRITE & EX_MEM_regd==ID_EX_inst_rt & (EX_MEM_regd!=0));
    
    //EX
    wire SHAMT;
    wire[31:0] ALU_INPUT1 = SHAMT ? ID_EX_shamt : FORWARD_EX_A ? EX_MEM_aluRes : FORWARD_MEM_A ? REG_WRITE_DATA : ID_EX_readData1;
    wire[31:0] ALU_INPUT2 = ID_EX_ALUSRC ? ID_EX_imm : FORWARD_EX_B ? EX_MEM_aluRes : FORWARD_MEM_B ? REG_WRITE_DATA : ID_EX_readData2;
    wire[31:0] MEM_WRITE_DATA = FORWARD_EX_B ? EX_MEM_aluRes : FORWARD_MEM_B ? REG_WRITE_DATA : ID_EX_readData2;
    wire[3:0] ALU_CTR_OUT;
    wire[31:0] ALU_RES;
    
    wire[4:0] REGD;
    
    ALUCtr aluCtr(
        .funct(ID_EX_inst[5:0]),
        .opCode(ID_EX_inst[31:26]),
        .aluOp(ID_EX_aluOp),
        .aluCtrOut(ALU_CTR_OUT),
        .shamt(SHAMT)
    );
    
    ALU alu(
        .input1(ALU_INPUT1),
        .input2(ALU_INPUT2),
        .aluCtr(ALU_CTR_OUT),
        .zero(ZERO),
        .aluRes(ALU_RES)
    );
    assign JR_ADDRESS = ALU_RES;
    assign BRANCH = ZERO & ID_EX_ctr[2];
    
    Mux_5 regdMux(
        .input1(ID_EX_inst_rd),
        .input2(ID_EX_inst_rt),
        .signal(ID_EX_REGDST),
        .outdata(REGD)
    );
        
    //MEM
    wire[31:0] MEM_READ_DATA;
    DataMemory dataMemory(
        .clk(clk),
        .address(EX_MEM_aluRes),
        .writeData(EX_MEM_writeData),
        .memWrite(EX_MEM_MEMWRITE),
        .memRead(EX_MEM_MEMREAD),
        .readData(MEM_READ_DATA)
    );
    
    //WB
    Mux_32 writeDataMux(
        .input1(MEM_WB_memData),
        .input2(MEM_WB_aluRes),
        .signal(MEM_WB_MEMTOREG),
        .outdata(REG_WRITE_DATA)
    );
    
    //clk
    always @(posedge clk) begin
        $display("PC:%d",PC);
        $display("STALL:%d",STALL);
        $display("ID_EX_MEMREAD:%d\nID_EX_inst_rt:%d\nIF_ID_inst_rs:%d\nID_EX_inst_rt:%d\nIF_ID_inst_rt:%d",
        ID_EX_MEMREAD,ID_EX_inst_rt,IF_ID_inst_rs,ID_EX_inst_rt,IF_ID_inst_rt);
        
        //MEM
        MEM_WB_aluRes <= EX_MEM_aluRes;
        MEM_WB_memData <= MEM_READ_DATA;
        MEM_WB_regd <= EX_MEM_regd;
        
        MEM_WB_ctr <= EX_MEM_ctr[1:0];
        $display("MEM_WB_aluRes:%d\nMEM_WB_memData:%d",MEM_WB_aluRes,MEM_WB_memData);
        $display("MEM_WB_regd:%d\nMEM_WB_ctr:%d",MEM_WB_regd,MEM_WB_ctr);
        $display("MEM_WB_REGWRITE:%d",MEM_WB_REGWRITE);
        $display("MEM_WB_MEMTOREG:%d",MEM_WB_MEMTOREG);
        //EX
        EX_MEM_aluRes <= ALU_RES;
        EX_MEM_writeData <= MEM_WRITE_DATA;
        EX_MEM_regd <= REGD;
        EX_MEM_ctr <= ID_EX_ctr[4:0];
        //EX_MEM_zero <= ZERO;
        $display("EX_MEM_aluRes:%d\nEX_MEM_writeData:%d\nEX_MEM_regd:%d"
            ,EX_MEM_aluRes,EX_MEM_writeData,EX_MEM_regd);
        $display("EX_MEM_ctr:%d\n",EX_MEM_ctr);
        
        //forwarding
        $display("FORWARD_EX_A:%d\nFORWARD_EX_B:%d",FORWARD_EX_A,FORWARD_EX_B);
        $display("FORWARD_MEM_A:%d\nFORWARD_MEM_B:%d",FORWARD_MEM_A,FORWARD_MEM_B);
        
        
        
        
        if(!STALL & !BRANCH & !JR) begin  
        ID_EX_branchshift <= IMM_SIGNEXT_SHIFT;
        ID_EX_inst <= IF_ID_inst;      
        ID_EX_imm <= IMM_SIGNEXT;
        ID_EX_readData1 <= REG_READ_DATA1;
        ID_EX_readData2 <= REG_READ_DATA2;
        ID_EX_inst_rs <= IF_ID_inst_rs;
        ID_EX_inst_rt <= IF_ID_inst_rt;
        ID_EX_inst_rd <= IF_ID_inst_rd;
        ID_EX_ctr <= CTR_OUT[8:0];
        ID_EX_shamt <= IF_ID_inst[10:6];
        ID_EX_pcp <= IF_ID_pcp;
        ID_EX_JR <= CTR_OUT[10];
        end
        else begin
        ID_EX_branchshift <= 0;
        ID_EX_ctr <= 0;
        ID_EX_inst <= 0;
        ID_EX_imm <= 0;
        ID_EX_readData1 <= 0;
        ID_EX_readData2 <= 0;
        ID_EX_inst_rs <= 0;
        ID_EX_inst_rt <= 0;
        ID_EX_inst_rd <= 0;
        ID_EX_shamt <= 0;
        ID_EX_pcp <= 0;
        ID_EX_JR <= 0;
        $display("clear");
        end
        
        $display("ID_EX_pcp:%d",ID_EX_pcp);      
        $display("ID_EX_ctr:%d\nID_EX_imm:%d\nID_EX_readData1:%d\nID_EX_readData2:%d"
            ,ID_EX_ctr,ID_EX_imm,ID_EX_readData1,ID_EX_readData2);
        $display("ID_EX_inst_rs:%d\nID_EX_inst_rt:%d\nID_EX_inst_rd:%d"
            ,ID_EX_inst_rs,ID_EX_inst_rt,ID_EX_inst_rd);
        $display("ID_EX_REGDST:%d\nID_EX_ALUSRC:%d\nID_EX_MEMREAD:%d\nID_EX_REGWRITE:%d",ID_EX_REGDST,ID_EX_ALUSRC,ID_EX_MEMREAD,ID_EX_REGWRITE);

        if(!STALL) begin
            PC <= NEXT_PC;
            if(!JUMP & !BRANCH & !JR) begin
            IF_ID_pcp <= PCP;
            IF_ID_inst <= IF_INST;
            end
            $display("IF_ID_pcp:%d\nIF_ID_inst:%b",IF_ID_pcp,IF_ID_inst);
            
        end
        if(JUMP) begin            
            IF_ID_inst <= 0;
            IF_ID_pcp <= 0;
            $display("jump is 1");
            $display("JUMP_ADDRESS:%d",JUMP_ADDRESS);                   
        end
        if(BRANCH) begin
            IF_ID_inst <= 0;
            IF_ID_pcp <= 0;
            /*ID_EX_ctr <= 0;      
            ID_EX_imm <= 0;
            ID_EX_readData1 <= 0;
            ID_EX_readData2 <= 0;
            ID_EX_inst_rs <= 0;
            ID_EX_inst_rt <= 0;
            ID_EX_inst_rd <= 0;
            ID_EX_shamt <= 0;
            ID_EX_pcp <= 0;
            ID_EX_JR <= 0;*/
            $display("branch is 1");
            $display("BRANCH_ADDRESS:%d",BRANCH_ADDRESS);
        end
        if(JR) begin
            IF_ID_inst <= 0;
            IF_ID_pcp <= 0;
            /*ID_EX_ctr <= 0;        
            ID_EX_imm <= 0;
            ID_EX_readData1 <= 0;
            ID_EX_readData2 <= 0;
            ID_EX_inst_rs <= 0;
            ID_EX_inst_rt <= 0;
            ID_EX_inst_rd <= 0;
            ID_EX_shamt <= 0;
            ID_EX_pcp <= 0;
            ID_EX_JR <= 0;*/
            $display("jr is 1");
            $display("JR_ADDRESS:%d",JR_ADDRESS);
        end
    end
    
    //reset
    always @(reset) begin
        if(reset==1) begin
        PC = 0;
        IF_ID_pcp = 0;
        IF_ID_inst = 0;
        ID_EX_branchshift = 0;
        ID_EX_ctr = 0;
        ID_EX_imm = 0;
        ID_EX_readData1 = 0;
        ID_EX_readData2 = 0;
        ID_EX_inst_rs = 0;
        ID_EX_inst_rt = 0;
        ID_EX_inst_rd = 0;
        ID_EX_shamt = 0;
        EX_MEM_aluRes = 0;
        EX_MEM_writeData = 0;
        EX_MEM_regd = 0;
        EX_MEM_ctr = 0;
        //EX_MEM_zero = 0;
        MEM_WB_aluRes = 0;
        MEM_WB_memData = 0;
        MEM_WB_regd = 0;
        MEM_WB_ctr = 0;
        end
    end
    
endmodule
