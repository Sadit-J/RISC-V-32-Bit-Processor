`timescale 1ns / 1ps

module InstructionMemory #(parameter ADD_WIDTH = 8, parameter REG_WIDTH = 32)
(
    pc_address,
    instruction,
    reset
);
    input wire reset;
    input[31:0] pc_address;
    output[31:0] instruction;
    
    reg [ADD_WIDTH - 1: 0] instruct_mem [REG_WIDTH - 1:0];
    
    always @(reset)
    begin
        if(reset == 1)
        begin
            //Adjust instructions as desired, currently set to default reset 0
            instruct_mem[3] = 8'h00;
            instruct_mem[2] = 8'h00;
            instruct_mem[1] = 8'h00;
            instruct_mem[0] = 8'h00;
            
            instruct_mem[7] = 8'h00;
            instruct_mem[6] = 8'h00;
            instruct_mem[5] = 8'h00;
            instruct_mem[4] = 8'h00;
            
            instruct_mem[11] = 8'h00;
            instruct_mem[10] = 8'h00;
            instruct_mem[9] = 8'h00;
            instruct_mem[8] = 8'h00;
            
            instruct_mem[15] = 8'h00;
            instruct_mem[14] = 8'h00;
            instruct_mem[13] = 8'h00;
            instruct_mem[12] = 8'h00;
            
            instruct_mem[19] = 8'h00;
            instruct_mem[18] = 8'h00;
            instruct_mem[17] = 8'h00;
            instruct_mem[16] = 8'h00;
            
            instruct_mem[23] = 8'h00;
            instruct_mem[22] = 8'h00;
            instruct_mem[21] = 8'h00;
            instruct_mem[20] = 8'h00;
            
            instruct_mem[27] = 8'h00;
            instruct_mem[26] = 8'h00;
            instruct_mem[25] = 8'h00;
            instruct_mem[24] = 8'h00;
            
            instruct_mem[31] = 8'h00;
            instruct_mem[30] = 8'h00;
            instruct_mem[29] = 8'h00;
            instruct_mem[28] = 8'h00;
        end
    end
    
    assign instruction = {instruct_mem[pc_address+3],instruct_mem[pc_address+2],instruct_mem[pc_address+1],instruct_mem[pc_address]};
    
endmodule
