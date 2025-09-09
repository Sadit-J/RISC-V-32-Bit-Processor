`timescale 1ns / 1ps

module DataMemory_tb;

    // Testbench signals
    reg clk;
    reg mem_read;
    reg mem_write;
    reg [2:0] funct3;
    reg [31:0] addr;
    reg [31:0] write_data;
    wire [31:0] read_data;

    // Instantiate DUT
    DataMemory uut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .funct3(funct3),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );


    always #5 clk = ~clk;

    task do_write(input [2:0] funct3_in, input [31:0] addr_in, input [31:0] data_in, input [127:0] name);
    begin
        @(negedge clk);
        mem_write = 1;
        mem_read  = 0;
        funct3    = funct3_in;
        addr      = addr_in;
        write_data = data_in;
        @(posedge clk);
        mem_write = 0;
    end
    endtask

    task do_read(input [2:0] funct3_in, input [31:0] addr_in, input [127:0] name);
    begin
        @(negedge clk);
        mem_write = 0;
        mem_read  = 1;
        funct3    = funct3_in;
        addr      = addr_in;
        @(posedge clk);
        #1;
        mem_read = 0;
    end
    endtask

    initial begin
        // Init
        clk = 0;
        mem_read = 0;
        mem_write = 0;
        funct3 = 3'b000;
        addr = 32'd0;
        write_data = 32'd0;



        do_write(3'b010, 32'h0000_0000, 32'hDEADBEEF, "SW");
        do_read (3'b010, 32'h0000_0000, "LW");

        do_write(3'b000, 32'h0000_0001, 32'h000000AA, "SB"); // store byte at offset=1
        do_read (3'b000, 32'h0000_0001, "LB");               // signed load
        do_read (3'b100, 32'h0000_0001, "LBU");              // unsigned load

        do_write(3'b001, 32'h0000_0002, 32'h0000_BEEF, "SH"); // store halfword
        do_read (3'b001, 32'h0000_0002, "LH");                // signed halfword
        do_read (3'b101, 32'h0000_0002, "LHU");               // unsigned halfword

        do_write(3'b010, 32'h0000_0004, 32'h12345678, "SW");
        do_read (3'b010, 32'h0000_0004, "LW");

        #20 $stop;
    end

endmodule
