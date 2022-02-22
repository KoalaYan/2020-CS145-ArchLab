# CS145-Labs
**2020 SJTU CS145 Computer Architecture Labs**
 ## Lab01 LED Flow Water Light
本实验实现了FPGA基础实验的LED Flow Water Light器件，每个周期计数器加一，当计数器值达到最大值时LED灯左移一位点亮。
 ## Lab02 4bits Adder
本实验首先实现了一个一位全加器，然后利用一位全加器设计了一个四位全加器，在加法器中仅利用与、或、异或三个操作，来仿真电路中的三种逻辑元件，达到实现四位加法功能的目的。
 ## Lab03 Ctr+ALUCtr+ALU
本实验实现了简易MIPS处理器中的几个重要部件：主控制单元(Ctr)、ALU控制单元(ALUCtr)以及算术逻辑单元ALU。他们分别用于产生处理器所需要的控制信号以及根据控制信号的不同进行相应算术逻辑运算操作输出结果。
 ## Lab04 dataMemory+Register+signalExtend
本实验实现了简易MIPS处理器中的几个重要部件：寄存器(Register)、存储器(Data Memory)和有符号拓展(Signal Extend)。他们分别用于暂时存放参与运算的数据和运算结果（具有接收数据、存放数据和输出数据的功能），用于大量存储数据以及对立即数进行有符号拓展。
 ## Lab05 Single Cycle MIPS
本实验实现了单周期类MIPS处理器，支持16条MIPS指令（包括R型指令：add、sub、and、or、slt、sll、srl、jr；I型指令：lw、sw、addi、andi、ori、beq；J型指令：j、jal），在继承了实验3、4中部分模块的基础上进行了功能修改以适配顶层组织文件，同时在原有MIPS接线基础上为了方便操作添加了部分辅助控制信号。
 ## Lab06 Pipeline MIPS
本实验实现了简单的类MIPS多周期流水线处理器，支持16条MIPS指令（包括R型指令：add、sub、and、or、slt、sll、srl、jr；I型指令：lw、sw、addi、andi、ori、beq；J型指令：j、jal），由于实验5中部分模块代码对于流水线设计可继承性较差，又进行了重新设计，同时为了实现流水线效果，增加了流水段寄存器等部件，支持流水线冒险(hazard)检测，插入停顿(stall)机制解决冒险，增加了前项通路(forwarding)减少流水线停顿延时，并通过predict-not-taken或延时转移策略解决控制冒险/竞争，减少控制竞争带来的流水线停顿延时，提高流水线处理器性能。
