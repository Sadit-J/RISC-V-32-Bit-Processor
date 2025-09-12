`timescale 1ns / 1ps

module RISCV_tb;

    // Testbench signals
    reg clk;
    reg reset;

    // DUT outputs to monitor
    wire [31:0] pc_in;
    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [31:0] reg_write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] immgen_out;
    wire [31:0] data_one;
    wire [31:0] data_two;
    wire [31:0] alu_result;


    // Instantiate Device Under Test (DUT)
    RISCV uut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out),
        .instruction(instruction),
        .reg_write_data(reg_write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .immgen_out(immgen_out),
        .data_one(data_one),
        .data_two(data_two),
        .alu_result(alu_result)
    );

    // Clock generator: 10ns period = 100 MHz
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Apply reset for a few cycles
        #20;
        reset = 0;

        // Let CPU run for some cycles
        #200;

        // Finish simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $display("Time | PC_out | Instruction | ALU_Result | RegWriteData");
        $monitor("%4t | %h | %h | %h | %h", 
                 $time, pc_out, instruction, alu_result, reg_write_data);
    end

endmodule
