`timescale 1ns / 1ps

module RISCV_tb;

    // Testbench signals
    reg clk;
    reg reset;

    wire [31:0] pc_in, pc_out;
    wire [31:0] instruction;
    wire [6:0]  instruction_opcode;
    wire [31:0] reg_write_data, read_data1, read_data2;
    wire [31:0] immgen_out;
    wire [31:0] data_one, data_two, alu_result, data_mem_read;
    wire control_branch, zero;
    // Instantiate DUT
    RISCV dut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out),
        .instruction(instruction),
        .instruction_opcode(instruction_opcode),
        .reg_write_data(reg_write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .immgen_out(immgen_out),
        .data_one(data_one),
        .data_two(data_two),
        .alu_result(alu_result),
        .data_mem_read(data_mem_read),
        .control_branch(control_branch),
        .zero(zero)
    );

    // Clock generator: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        reset = 1;

        // Apply reset
        #20 reset = 0;

        // Run CPU for some cycles
        #200;

        // End simulation
        $finish;
    end

    // Monitor outputs for debug
    initial begin
        $display("Time | PC_out | Instruction | Opcode | ALU_result | ReadData1 | ReadData2");
        $monitor("%4t | %h | %h | %b | %h | %h | %h",
                  $time, pc_out, instruction, instruction_opcode, alu_result, read_data1, read_data2);
    end

endmodule
