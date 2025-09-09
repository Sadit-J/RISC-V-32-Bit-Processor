`timescale 1ns / 1ps

module ControlUnit_tb;

    reg [6:0] opcode;
    wire alu_src;
    wire mem_to_reg;
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire [1:0] aluop;

    ControlUnit uut (
        .opcode(opcode),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .aluop(aluop)
    );

    task run_test(input [6:0] opc, input [127:0] name);
    begin
        opcode = opc;
        #5; 
        $display("TEST %-10s | opcode=%b | alu_src=%b mem_to_reg=%b reg_write=%b mem_read=%b mem_write=%b branch=%b aluop=%b",
                  name, opcode, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, aluop);
    end
    endtask

    initial begin
        $display("Starting ControlUnit tests...");

        run_test(7'b0110011, "R-type");     // R-type
        run_test(7'b0010011, "I-type imm"); // I-type immediate
        run_test(7'b0000011, "Load");       // Load
        run_test(7'b0100011, "Store");      // Store
        run_test(7'b1100011, "Branch");     // Branch
        run_test(7'b1111111, "Invalid");    // Invalid / default

        $display("ControlUnit tests finished.");
        #10 $stop;
    end

endmodule
