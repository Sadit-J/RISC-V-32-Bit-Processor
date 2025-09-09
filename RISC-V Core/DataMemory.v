`timescale 1ns / 1ps

module DataMemory(
    clk,
    mem_read,    
    mem_write,   
    funct3,      
    addr,        
    write_data,
    read_data 
);

    input wire clk;
    input wire mem_read;   
    input wire mem_write; 
    input wire [2:0]  funct3;
    input wire [31:0] addr;      
    input wire [31:0] write_data; 
    output reg  [31:0] read_data;    
    
    reg [31:0] mem [0:31];

    wire [7:0]  byte_addr  = addr[7:0];
    wire [1:0]  offset     = addr[1:0];
    wire [31:0] word       = mem[addr[9:2]]; // word-aligned access, make sure its divisible by 4

    always @(posedge clk) begin
        if (mem_write) begin
            case (funct3)
                //Store Byte
                3'b000: begin
                    case (offset)
                        2'b00: mem[addr[9:2]][7:0]   <= write_data[7:0];
                        2'b01: mem[addr[9:2]][15:8]  <= write_data[7:0];
                        2'b10: mem[addr[9:2]][23:16] <= write_data[7:0];
                        2'b11: mem[addr[9:2]][31:24] <= write_data[7:0];
                    endcase
                end
                
                //Store Half
                3'b001: begin
                    if (offset[1] == 1'b0)
                        mem[addr[9:2]][15:0] <= write_data[15:0];
                    else
                        mem[addr[9:2]][31:16] <= write_data[15:0];
                end
                
                //Store Word
                3'b010: begin
                    mem[addr[9:2]] <= write_data;
                end
            endcase
        end
    end

    always @(*) begin
        if (mem_read) begin
            case (funct3)
                //Load Byte Signed
                3'b000: begin 
                    case (offset)
                        2'b00: read_data = {{24{word[7]}},  word[7:0]};
                        2'b01: read_data = {{24{word[15]}}, word[15:8]};
                        2'b10: read_data = {{24{word[23]}}, word[23:16]};
                        2'b11: read_data = {{24{word[31]}}, word[31:24]};
                    endcase
                end
                
                //Load Half Signed
                3'b001: begin
                    if (offset[1] == 1'b0)
                        read_data = {{16{word[15]}}, word[15:0]};
                    else
                        read_data = {{16{word[31]}}, word[31:16]};
                end
                
                //Load Word
                3'b010: read_data = word;
                
                //Load Byte Unsigned
                3'b100: begin
                    case (offset)
                        2'b00: read_data = {24'b0, word[7:0]};
                        2'b01: read_data = {24'b0, word[15:8]};
                        2'b10: read_data = {24'b0, word[23:16]};
                        2'b11: read_data = {24'b0, word[31:24]};
                    endcase
                end
                
                //Load Half Unsigned
                3'b101: begin 
                    if (offset[1] == 1'b0)
                        read_data = {16'b0, word[15:0]};
                    else
                        read_data = {16'b0, word[31:16]};
                end
                default: read_data = 32'b0;
            endcase
        end else begin
            read_data = 32'b0;
        end
    end
endmodule
