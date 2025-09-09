`timescale 1ns / 1ps

module pc_tb;

    reg clk;
    reg reset;
    reg [31:0] PC_in;
    wire [31:0] PC_out;

    ProgramCounter uut (
        .clk(clk),
        .reset(reset),
        .PC_in(PC_in),
        .PC_out(PC_out)
    );

    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        PC_in = 0;

        reset = 1;
        #10;  
        reset = 0;
        $display("Reset deasserted, PC_out = %h", PC_out);


        #10 PC_in = 32'h0000_0004;  
        #10 $display("PC_in = %h, PC_out = %h", PC_in, PC_out);

        #10 PC_in = 32'h0000_0008; 
        #10 $display("PC_in = %h, PC_out = %h", PC_in, PC_out);

        #10 PC_in = 32'h0000_000C;
        #10 $display("PC_in = %h, PC_out = %h", PC_in, PC_out);

        #10 reset = 1;
        #10 $display("Reset applied, PC_out = %h", PC_out);
        reset = 0;

        #20;
        $stop;
    end
    
    
    
    
endmodule
