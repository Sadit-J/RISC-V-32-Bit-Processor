`timescale 1ns / 1ps

module ALU_tb;

    reg [31:0] data_one;
    reg [31:0] data_two;
    reg [3:0] alu_op;
    wire zero;
    wire [31:0] alu_result;

    ALU uut (
        .data_one(data_one),
        .data_two(data_two),
        .alu_op(alu_op),
        .zero(zero),
        .alu_result(alu_result)
    );


    task run_test(input [31:0] a, input [31:0] b, input [3:0] op);
    begin
        data_one = a;
        data_two = b;
        alu_op   = op;
        #10;
        $display("ALU_OP=%b | A=%0d (0x%h) | B=%0d (0x%h) | RESULT=%0d (0x%h) | ZERO=%b",
                 alu_op, data_one, data_one, data_two, data_two, alu_result, alu_result, zero);
    end
    endtask

    initial begin
        data_one = 0;
        data_two = 0;
        alu_op   = 0;


        run_test(10, 5, 4'b0000); // ADD
        run_test(10, 5, 4'b0001); // SUB
        run_test(1, 2, 4'b0010);  // SLL
        run_test(5, 10, 4'b0011); // SLT signed
        run_test(5, 10, 4'b0100); // SLTU
        run_test(6, 3, 4'b0101);  // XOR
        run_test(-32'h10, 2, 4'b0110); // SRA
        run_test(32'hF0F0F0F0, 4, 4'b0111); // SRL
        run_test(32'hFF00, 32'h0F0F, 4'b1000); // OR
        run_test(32'hFF00, 32'h0F0F, 4'b1001); // AND

        // Branch-style conditions
        run_test(5, 5, 4'b1010); // !(A == B)
        run_test(5, 6, 4'b1011); // !(A != B)
        run_test(5, 10, 4'b1100); // !(A < B signed)
        run_test(10, 5, 4'b1101); // !(A >= B signed)

        $display("ALU tests finished.");
        $stop;
    end

endmodule
