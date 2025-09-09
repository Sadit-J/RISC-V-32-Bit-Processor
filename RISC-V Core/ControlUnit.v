`timescale 1ns / 1ps

module ControlUnit(
  opcode,
  alu_src,
  mem_to_reg,
  reg_write,
  mem_read,
  mem_write,
  branch,
  aluop
  );
  
  input [6:0] opcode;
  
  output reg alu_src;
  output reg mem_to_reg;
  output reg reg_write;
  output reg mem_read;
  output reg mem_write;
  output reg branch;
  output reg [1:0] aluop;
  
  
  always @(*)
    begin
      
      //R-type
      if (opcode == 7'b0110011)
        begin
          alu_src = 1'b0;
          mem_to_reg = 1'b0;
          reg_write = 1'b1;
          mem_read = 1'b0;
          mem_write = 1'b0;
          branch = 1'b0;
          aluop = 2'b10;
        end
      
      //R-type Constant
      else if (opcode == 7'b0010011)
        begin
          alu_src = 1'b1;
          mem_to_reg = 1'b0;
          reg_write = 1'b1;
          mem_read = 1'b0;
          mem_write = 1'b0;
          branch = 1'b0;
          aluop = 2'b10;
        end
      
      //I-type - Load
      else if (opcode == 7'b0000011)
        begin
          alu_src = 1'b1;
          mem_to_reg = 1'b1;
          reg_write = 1'b1;
          mem_read = 1'b1;
          mem_write = 1'b0;
          branch = 1'b0;
          aluop = 2'b00;
        end
      
      //I-type - Store
      else if (opcode == 7'b0100011)
        begin
          alu_src = 1'b1;
          mem_to_reg = 1'bx;
          reg_write = 1'b0;
          mem_read = 1'b0;
          mem_write = 1'b1;
          branch = 1'b0;
          aluop =2'b00;
        end
        
      //B-type
      else if (opcode == 7'b1100011)
        begin
          alu_src = 1'b0;
          mem_to_reg = 1'bx;
          reg_write = 1'b0;
          mem_read = 1'b0;
          mem_write = 1'b0;
          branch = 1'b1;
          aluop = 2'b01;
        end
      
      else
        begin
          alu_src = 1'b0;
          mem_to_reg = 1'b0;
          reg_write = 1'b0;
          mem_read = 1'b0;
          mem_write = 1'b0;
          branch = 1'b0;
          aluop =2'b00;
     end
   end
 endmodule
