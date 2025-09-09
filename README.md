# RISC-V-32-Bit-Processor

This project is a single cycle 32-bit RISC-V CPU implemented in Verilog HDL, designed and tested using AMD Vivado.
The modules within the processor includes:
- Program Counter (PC)
- Instruction Memory
- Control Unit
- Register File
- Immediate Generator (ImmGen)
- ALU & ALU Control
- Branching Unit
- Data Memory

Each module was tested individually with testbenches written in Verilog. Currently, the instruction memory has a default memory which can be modified to run instructions specified by the user. 

# Instructions
`R-type`: ADD, SUB, SLT, XOR, OR, AND, SLL, SRL, SRA, SLT, SLTU
`I-type`: ADDI, XORI, ORI, ANDI, SLLI, SRLI, SRAI, SLTI, SLTIU, LB, LH, LW, LBU, LHU
`S-type`: SB, SH, SW
`B-type`: BEQ, BNE, BLT, BGE, BLTU, BGEU

# Future Work
- Add J-type and U-type instructions
- Allow users to add a hex file for instruction memory to read from
- Research and implement pipelining
