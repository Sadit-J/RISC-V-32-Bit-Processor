`timescale 1ns / 1ps

module RegFile_tb;

    reg  [4:0] rs1, rs2, rd;
    reg  [31:0] write_data;
    reg  reg_write, reset, clk;
    wire [31:0] read_data1, read_data2;

    RegFile uut (
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .reset(reset),
        .clk(clk),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    
    always #5 clk = ~clk;

    // Task for a write
    task write_reg(input [4:0] regnum, input [31:0] value);
    begin
        @(posedge clk);
        rd = regnum;
        write_data = value;
        reg_write = 1;
        @(posedge clk);
        reg_write = 0;
    end
    endtask

    // Task for a read
    task read_regs(input [4:0] r1, input [4:0] r2);
    begin
        rs1 = r1;
        rs2 = r2;
        #2; // small delay to let combinational logic settle
        $display("Read rs1=%0d -> %h | rs2=%0d -> %h",
                  rs1, read_data1, rs2, read_data2);
    end
    endtask

    initial begin
        // Initialize
        clk = 0;
        reset = 0;
        reg_write = 0;
        rs1 = 0; rs2 = 0; rd = 0; write_data = 0;

        // Apply reset
        $display("Applying reset...");
        reset = 1;
        #5 reset = 0;

        // Write to some registers
        write_reg(5, 32'hAAAA5555);
        write_reg(10, 32'h12345678);
        write_reg(15, 32'hDEADBEEF);

        // Read back values
        read_regs(5, 10);
        read_regs(15, 0);

        // Overwrite register
        write_reg(5, 32'h11112222);
        read_regs(5, 10);

        $display("RegFile tests finished.");
        #20 $stop;
    end

endmodule
