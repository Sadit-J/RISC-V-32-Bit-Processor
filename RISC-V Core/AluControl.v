`timescale 1ns / 1ps

module AluControl(
  aluop,
  funct3,
  funct7,
  operation
  );
  
  input [1:0] aluop;
  input [2:0] funct3;
  input [6:0] funct7;
  output reg [3:0] operation;
  
  always @ (*)
    begin
    
    //R-Type Instructions
      if (aluop == 2'b10) 
        begin
           if (funct3 == 3'b000)
           begin
              if (funct7 == 7'b0000000)
                  begin 
                    operation = 4'b0000;
                  end
              else
                  begin
                    operation = 4'b0001;
                  end
           end
           else if (funct3 == 3'b001)
           begin 
                operation = 4'b0010;
           end
           
           else if (funct3 == 3'b010)
           begin 
                operation = 4'b0011;
           end
           
           else if (funct3 == 3'b011)
           begin 
                operation = 4'b0100;
           end
           
           else if (funct3 == 3'b100)
           begin 
                operation = 4'b0101;
           end
             
           else if (funct3 == 3'b101)
           begin 
               if (funct7 == 7'b0000000)
                  begin 
                    operation = 4'b0110;
                  end
              else
                  begin
                    operation = 4'b0111;
                  end
           end
           
           else if (funct3 == 3'b110)
           begin 
                operation = 4'b1000;
           end
           else if (funct3 == 3'b111)
           begin 
                operation = 4'b1001;
           end
        end
        
      //Load and Store with Immediate
      if (aluop==2'b00)
        begin
          operation = 4'b0001;
        end
        
        
      //Branch  
      if (aluop==2'b01)
        begin
          if (funct3 == 3'b000)
            begin
              operation = 4'b1010;
            end
          if (funct3 == 3'b001)
            begin
              operation = 4'b1011;
            end
          if (funct3 == 3'b100)
            begin
              operation = 4'b1100;
            end
          if (funct3 == 3'b101)
            begin
              operation = 4'b1101;
            end
        end
    end
endmodule
