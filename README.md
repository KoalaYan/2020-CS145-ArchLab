# CS145-Labs
**2020 SJTU CS145 Computer Architecture Labs**
 ## Lab01 LED Flow Water Light
 This experiment implements the LED Flow Water Light device for FPGA basic experiments. Each cycle the counter is added by one, and the LED lights up one bit to the left when the counter value reaches its maximum value.
 ## Lab02 4bits Adder
 This experiment first implements a one-bit full adder, and then designs a four-bit full adder using a one-bit full adder. Only three operations, namely, with, or, and different, are used in the adder to simulate the three logic elements in the circuit for the purpose of realizing the four-bit addition function.
 ## Lab03 Ctr+ALUCtr+ALU
 This experiment implements several important components of the simple MIPS processor: the main control unit (Ctr), the ALU control unit (ALUCtr), and the arithmetic logic unit ALU, which are used to generate the control signals required by the processor and to perform the corresponding arithmetic logic operations and output the results according to the different control signals.
 ## Lab04 dataMemory+Register+signalExtend
 This experiment implements several important parts of the simple MIPS processor: Register, Data Memory, and Signal Extend. They are used to temporarily store the data and results of operations (with the function of receiving data, storing data and outputting data), to store a large amount of data and to perform signed extensions of immediate numbers, respectively.
 ## Lab05 Single Cycle MIPS
 This experiment implements a single-cycle class MIPS processor, supporting 16 MIPS instructions (including R-type instructions: add, sub, and, or, slt, sll, srl, jr; I-type instructions: lw, sw, addi, andi, ori, beq; J-type instructions: j, jal), in inheritance of some of the modules in experiments 3 and 4 on the basis of functional modifications to adapt to the top-level organization file, while adding some of the auxiliary control signals based on the original MIPS wiring for ease of operation.
 ## Lab06 Pipeline MIPS
This experiment implements a simple MIPS-like multi-cycle pipeline processor, supporting 16 MIPS instructions (including R-type instructions: add, sub, and, or, slt, sll, srl, jr; I-type instructions: lw, sw, addi, andi, ori, beq; J-type instructions: j, jal), as part of the module code in experiment 5 for In order to achieve the effect of pipeline, we added components such as pipeline segment registers, supported pipeline adventure (hazard) detection, inserted stall (stall) mechanism to solve the adventure, added the forwarding path (forwarding) to reduce the pipeline stall delay, and resolved the control by predict-not- taken or delay transfer strategy to solve control risk/competition, reduce pipeline stall delay caused by control competition, and improve pipeline processor performance.

