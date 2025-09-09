`timescale 1ns / 1ps

module AluControl_tb;

    reg [1:0] aluop;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire [3:0] operation;


    AluControl uut (
        .aluop(aluop),
        .funct3(funct3),
        .funct7(funct7),
        .operation(operation)
    );

    task run_test(input [1:0] aluop_in, input [2:0] funct3_in, input [6:0] funct7_in, input [127:0] name);
    begin
        aluop = aluop_in;
        funct3 = funct3_in;
        funct7 = funct7_in;
        #5;
        $display("TEST %-12s | aluop=%b funct3=%b funct7=%b => operation=%b",
                 name, aluop, funct3, funct7, operation);
    end
    endtask

    initial begin
        $display("Starting AluControl tests...");

        // R-type ADD
        run_test(2'b10, 3'b000, 7'b0000000, "ADD");
        // R-type SUB
        run_test(2'b10, 3'b000, 7'b0100000, "SUB");
        // R-type SLL
        run_test(2'b10, 3'b001, 7'b0000000, "SLL");
        // R-type SLT
        run_test(2'b10, 3'b010, 7'b0000000, "SLT");
        // R-type SLTU
        run_test(2'b10, 3'b011, 7'b0000000, "SLTU");
        // R-type XOR
        run_test(2'b10, 3'b100, 7'b0000000, "XOR");
        // R-type SRL
        run_test(2'b10, 3'b101, 7'b0000000, "SRL");
        // R-type SRA
        run_test(2'b10, 3'b101, 7'b0100000, "SRA");
        // R-type OR
        run_test(2'b10, 3'b110, 7'b0000000, "OR");
        // R-type AND
        run_test(2'b10, 3'b111, 7'b0000000, "AND");

        // Load/Store (aluop=00 → ADD for address calc)
        run_test(2'b00, 3'b000, 7'b0000000, "LOAD/STORE");

        // Branch BEQ
        run_test(2'b01, 3'b000, 7'b0000000, "BEQ");
        // Branch BNE
        run_test(2'b01, 3'b001, 7'b0000000, "BNE");
        // Branch BLT
        run_test(2'b01, 3'b100, 7'b0000000, "BLT");
        // Branch BGE
        run_test(2'b01, 3'b101, 7'b0000000, "BGE");

        #10 $stop;
    end

endmodule