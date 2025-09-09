`timescale 1ns / 1ps

module InstructionMemory_tb;

    // Testbench signals
    reg reset;
    reg [31:0] pc_address;
    wire [31:0] instruction;

    // Instantiate DUT
    InstructionMemory uut (
        .pc_address(pc_address),
        .instruction(instruction),
        .reset(reset)
    );

    initial begin
        // Initialize
        reset = 0;
        pc_address = 0;

        reset = 1;
        #5 reset = 0;

        #5 pc_address = 0;   #5 $display("PC=%0d | Instruction=%h", pc_address, instruction);
        #5 pc_address = 4;   #5 $display("PC=%0d | Instruction=%h", pc_address, instruction);
        #5 pc_address = 8;   #5 $display("PC=%0d | Instruction=%h", pc_address, instruction);
        #5 pc_address = 12;  #5 $display("PC=%0d | Instruction=%h", pc_address, instruction);
        #5 pc_address = 16;  #5 $display("PC=%0d | Instruction=%h", pc_address, instruction);
        #5 pc_address = 20;  #5 $display("PC=%0d | Instruction=%h", pc_address, instruction);
        #5 pc_address = 24;  #5 $display("PC=%0d | Instruction=%h", pc_address, instruction);
        #5 pc_address = 28;  #5 $display("PC=%0d | Instruction=%h", pc_address, instruction);
        #10 $stop;
    end

endmodule
