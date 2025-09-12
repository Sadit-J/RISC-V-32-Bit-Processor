`timescale 1ns / 1ps

module RISCV(
    clk,
    reset,
    reg_write_data, 
    read_data1, 
    read_data2,
    pc_in,
    pc_out,
    instruction,
    immgen_out,
    data_one, data_two, 
    alu_result,
    instruction_opcode,
    data_mem_read,
    control_branch,
    zero
    );
    
    input wire clk;
    input wire reset;
    
    //Program Counter   
    wire pc_reset;
    output wire [31:0] pc_in, pc_out;
    
    //Instruction Memory     
    wire inst_mem_reset;
    output wire [31:0] instruction;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

    //Control Unit  
    wire control_alu_src, control_mem_to_reg, control_reg_write, control_mem_read, control_mem_write;
    output wire control_branch;
    wire [1:0] control_aluop;
    output wire [6:0] instruction_opcode;
    
    //Register File   
    wire [4:0] rs_in, rs2_in, rd_in;
    output wire [31:0] reg_write_data, read_data1, read_data2;
    wire reg_write, regfile_reset;
    
    //Imm Gen
    wire [31:0] immgen_in;
    output wire [31:0] immgen_out; 
    
    //Branch Unit
    wire [31:0] branch_out; 
    wire [31:0] branch_data;
    
    //ALU Control
    wire [2:0] alu_funct3;
    wire [6:0] alu_funct7;
    wire [3:0] alu_operation;
    wire [1:0] aluop_out;
    
    //ALU
    output wire zero;
    output wire [31:0] data_one, data_two, alu_result;
    wire [3:0] aluop_in;
    
    //Data Memory
    wire mem_write, mem_read;
    wire [2:0] data_mem_funct3;
    wire [31:0] addr, data_mem_write;
    output wire [31:0] data_mem_read;
    
    
    //Connecting Everything
    ProgramCounter pc(
        .clk(clk),
        .reset(reset),
        .PC_in(pc_in), 
        .PC_out(pc_out)    
    );
    
    InstructionMemory inst_mem(
         .pc_address(pc_out),
         .instruction(instruction),
         .reset(reset)    
    );
    
    assign instruction_opcode = instruction[6:0];
    ControlUnit control_unit(
      .opcode(instruction_opcode),
      .alu_src(control_alu_src),
      .mem_to_reg(control_mem_to_reg),
      .reg_write(control_reg_write),
      .mem_read(control_mem_read),
      .mem_write(control_mem_write),
      .branch(control_branch),
      .aluop(control_aluop)
      );
    
    assign reg_write_data = control_mem_to_reg ? data_mem_read : alu_result; 
    
    RegFile reg_file(
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .write_data(reg_write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .reg_write(control_reg_write),
        .reset(reset),
        .clk(clk)    
    );
    

    AluControl alu_control(
      .aluop(control_aluop),
      .funct3(instruction[14:12]),
      .funct7(instruction[31:25]),
      .operation(alu_operation)
      );
      

    ImmGen immgen(
        .instruction(instruction),
        .imm_result(immgen_out)
      );
      
    
    assign data_two = (control_alu_src) ? immgen_out : read_data2;
    assign data_one = read_data1;

    ALU alu(
        .data_one(data_one),
        .data_two(data_two),
        .zero(zero),
        .alu_result(alu_result),
        .alu_op(alu_operation)    
        );
        
    assign branch_data = immgen_out;
    assign branch_out = pc_out + branch_data;
 
    assign pc_in = (zero & control_branch) ? branch_out : (pc_out + 4);

    DataMemory data_mem(
    .clk(clk),
    .mem_read(control_mem_read),    
    .mem_write(control_mem_write),   
    .funct3(instruction[14:12]),      
    .addr(alu_result),        
    .write_data(read_data2), 
    .read_data(data_mem_read)   
    );

endmodule
