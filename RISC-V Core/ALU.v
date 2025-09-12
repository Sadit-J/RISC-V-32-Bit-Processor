`timescale 1ns / 1ps

module ALU(
    data_one,
    data_two,
    zero,
    alu_result,
    alu_op    
    );
    
    input [31:0] data_one;
    input [31:0] data_two;
    input [3:0] alu_op;
    
    output reg zero;
    output reg [31:0] alu_result;
    
    always @(*)
    begin
      case (alu_op)
        4'b0000: alu_result <= data_one + data_two;
        4'b0001: alu_result <= data_one - data_two;
        4'b0010: alu_result <= data_one << data_two;
        4'b0011: alu_result <= $signed(data_one) < $signed(data_two);
        4'b0100: alu_result <= data_one < data_two;
        4'b0101: alu_result <= data_one ^ data_two;
        4'b0110: alu_result <= $signed(data_one) >>> data_two;
        4'b0111: alu_result <= data_one >> data_two;
        4'b1000: alu_result <= data_one | data_two;
        4'b1001: alu_result <= data_one & data_two;
       
       
        //Set ALU result to 0, such that zero flag is on
        4'b1010: alu_result <= (data_one == data_two) ? 32'h0 : 32'hFFFFFFFF;
        4'b1011: alu_result <= data_one != data_two ? 32'h0 : 32'hFFFFFFFF;
        4'b1100: alu_result <= ($signed(data_one) < $signed(data_two)) ? 32'h0 : 32'hFFFFFFFF;
        4'b1101: alu_result <= ($signed(data_one) >= $signed(data_two)) ? 32'h0 : 32'hFFFFFFFF;
      
      endcase
      
      if (alu_result == 0)
        zero <= 1;
      else
        zero <= 0;
    end
    
    
endmodule
