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
            // Instruction 0: ADDI x1, x0, 5
            // Hex: 0x00500093
            instruct_mem[0] = 8'h93;
            instruct_mem[1] = 8'h00;
            instruct_mem[2] = 8'h50;
            instruct_mem[3] = 8'h00;
            
            // Instruction 1: ADDI x2, x0, 10
            // Hex: 0x00A00113
            instruct_mem[4] = 8'h13;
            instruct_mem[5] = 8'h01;
            instruct_mem[6] = 8'ha0;
            instruct_mem[7] = 8'h00;
            
            // Instruction 2: ADD x3, x1, x2
            // Hex: 0x002081B3
            instruct_mem[8]  = 8'hb3;
            instruct_mem[9]  = 8'h81;
            instruct_mem[10] = 8'h20;
            instruct_mem[11] = 8'h00;
            
            // Instruction 3: sw x3, 0(x5)
            // Hex: 0x0032a023
            instruct_mem[12] = 8'h23;
            instruct_mem[13] = 8'hA0;
            instruct_mem[14] = 8'h32;
            instruct_mem[15] = 8'h00;
            
            // Instruction 4: lw x7, 0(x5)
            // Hex: 0x0002a383
            instruct_mem[16] = 8'h83;
            instruct_mem[17] = 8'hA3;
            instruct_mem[18] = 8'h02;
            instruct_mem[19] = 8'h00;
            
            // Instruction 5: sub x7, x7, x2
            // Hex: 0x402383b3
            instruct_mem[20] = 8'hb3;
            instruct_mem[21] = 8'h83;
            instruct_mem[22] = 8'h23;
            instruct_mem[23] = 8'h40;
            
            // Instruction 6: lw x7, 0(x5))
            // Hex: 0x00138463
            instruct_mem[24] = 8'h63;
            instruct_mem[25] = 8'h84;
            instruct_mem[26] = 8'h13;
            instruct_mem[27] = 8'h00;
            
            // Instruction 7: 
            instruct_mem[28] = 8'hb3;
            instruct_mem[29] = 8'h83;
            instruct_mem[30] = 8'h23;
            instruct_mem[31] = 8'h40;
            

        end
    end
    
    assign instruction = {instruct_mem[pc_address+3],instruct_mem[pc_address+2],instruct_mem[pc_address+1],instruct_mem[pc_address]};
    
endmodule
