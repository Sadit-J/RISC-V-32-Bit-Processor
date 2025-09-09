`timescale 1ns / 1ps

module RegFile(
    rs1,
    rs2,
    rd,
    write_data,
    read_data1,
    read_data2,
    reg_write,
    reset,
    clk
    
    );
    
    input [4:0] rs1;
    input [4:0] rs2;
    input [4:0] rd;
    input [31:0] write_data;
    input reg_write;
    input reset;
    input clk;
    
    output reg [31:0] read_data1;
    output reg [31:0] read_data2;

    reg [31:0] reg_mem [31:0];
    integer i;
   
    always @ (*)
     begin
       if (reset)
         begin
           for (i = 0; i < 32; i = i+1)
                reg_mem[i] <= 32'd0;
           read_data1 = 32'd0;
           read_data2 = 32'd0;
         end
       else
         begin
           read_data1 = reg_mem[rs1];
           read_data2 = reg_mem[rs2];
         end
     end
     
    always @(posedge clk)
      begin
        if (reg_write) 
          begin
            reg_mem[rd] = write_data;
          end
      end
    
    
endmodule
