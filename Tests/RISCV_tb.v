`timescale 1ns / 1ps

module RISCV_tb();
    reg clk;
    reg reset;

    wire [31:0] pc_in;
    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [31:0] reg_write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    RISCV uut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out),
        .instruction(instruction),
        .reg_write_data(reg_write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;

        #20;
        reset = 0;

        #300;

        $finish;
    end

    initial begin
        $monitor("T=%0t | PC_out=%h | Instr=%h | RegWriteData=%h | Read1=%h | Read2=%h",
                 $time,
                 pc_out,
                 instruction,
                 reg_write_data,
                 read_data1,
                 read_data2);
    end

endmodule
