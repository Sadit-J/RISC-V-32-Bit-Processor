`timescale 1ns / 1ps

module ProgramCounter(
    clk,
    reset, 
    PC_in,
    PC_out

    );
    
    input clk;
    input reset;
    input [31:0] PC_in;
    output reg [31:0] PC_out;
    
    always @(posedge clk or posedge reset)
        begin
            if (reset == 1'b1)
            begin
                PC_out <= 32'b0;
            end
            else begin
                PC_out <= PC_in;
            end
        end
    
   
endmodule
