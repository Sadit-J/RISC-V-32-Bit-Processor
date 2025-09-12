`timescale 1ns / 1ps

module ImmGen_tb();

    reg [31:0] instruction;
    wire [31:0] imm_result;

    // DUT
    ImmGen uut (
        .instruction(instruction),
        .imm_result(imm_result)
    );

    initial begin
        $display("=== ImmGen Testbench Start ===");

        // I-type Load: LW x1, 0(x2)
        // opcode = 0000011, imm = 000000000100 (decimal 4)
        instruction = 32'b000000000100_00010_010_00001_0000011;
        #10;
        $display("LW imm: %d (hex=%h)", imm_result, imm_result);

        // I-type ALU: ADDI x1, x2, -5
        // opcode = 0010011, imm = 1111111011 (-5)
        instruction = 32'b111111111011_00010_000_00001_0010011;
        #10;
        $display("ADDI imm: %d (hex=%h)", imm_result, imm_result);

        // S-type Store: SW x1, 8(x2)
        // opcode = 0100011, imm = 000000001000 (decimal 8)
        instruction = 32'b1000000_00001_00010_010_01000_0100011;
        #10;
        $display("SW imm: %d (hex=%h)", imm_result, imm_result);

        // B-type Branch: BEQ x1, x2, 16
        // opcode = 1100011, imm = 000000010000 (decimal 16)
        instruction = 32'b0000000_00010_00001_000_00010_1100011;
        #10;
        $display("BEQ imm: %d (hex=%h)", imm_result, imm_result);

        // Default case: NOP (all zeros)
        instruction = 32'b0;
        #10;
        $display("NOP imm: %d (hex=%h)", imm_result, imm_result);

        $display("=== ImmGen Testbench End ===");
        $finish;
    end

endmodule
