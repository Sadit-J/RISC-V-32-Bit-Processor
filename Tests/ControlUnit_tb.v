`timescale 1ns / 1ps

module ControlUnit_tb;

    // Testbench signals
    reg clk;
    reg [6:0] opcode;

    wire alu_src;
    wire mem_to_reg;
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire [1:0] aluop;

    // Instantiate DUT
    ControlUnit dut (
        .clk(clk),
        .opcode(opcode),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .aluop(aluop)
    );

    // Clock generator (not really needed here but included for consistency)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        opcode = 7'b0000000;

        // Apply different test cases
        #10 opcode = 7'b0110011; // R-type
        #10 opcode = 7'b0010011; // I-type (Immediate)
        #10 opcode = 7'b0000011; // Load
        #10 opcode = 7'b0100011; // Store
        #10 opcode = 7'b1100011; // Branch
        #10 opcode = 7'b1111111; // Unknown/Default

        // Finish simulation
        #20 $finish;
    end

    // Monitor results
    initial begin
        $display("Time | Opcode    | alu_src mem_to_reg reg_write mem_read mem_write branch aluop");
        $monitor("%4t | %b |    %b        %b          %b        %b        %b      %b    %b",
                 $time, opcode, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, aluop);
    end

endmodule
