`timescale 1ns / 1ps

module ImmGen(
    instruction,
    imm_result
  );
  
  input [31:0] instruction;
  output reg [31:0] imm_result;
  
  always @(*)
    begin
      case (instruction[6:0])
       7'b0000011:
          begin
            imm_result[11:0] = instruction[31:20];
          end
       7'b0100011:
          begin
            imm_result[11:0] = {instruction[31:25], instruction[11:7]};
          end
       7'b1100011:
          begin
            imm_result[11:0] = {instruction[31], instruction[30:25], instruction[11:8], instruction[7]};
          end
      endcase
      imm_result = {{20{imm_result[11]}},{imm_result[11:0]}};
    end  
endmodule
