`timescale 1ns / 1ps

module ALUdecode(
input [31:0]B,IMM,
input [5:0]opcode,
output [2:0]func,
output [31:0]opB
    );
    reg [2:0]y;
    reg [31:0]i;
    always@(*)
    begin
    case(opcode)
    6'b000001,6'b000010,6'b000011 : begin
                                    y=3'b001;
                                    i=B;
                                    end
    6'b000100 : begin
                y=3'b010;
                i=B;
                end
    6'b000101 : begin
                y=3'b011;
                i=B;
                end
    6'b000110 : begin
                y=3'b100;
                i=B;
                end
    6'b000111 : begin
                y=3'b101;
                i=B;
                end
    6'b001000 : begin
                y=3'b110;
                i=B;
                end
    6'b001001 : begin
                y=3'b001;
                i=IMM;
                end
    6'b001010 : begin
                y=3'b010;
                i=IMM;
                end
    6'b001011 : begin
                y=3'b110;
                i=IMM;
                end            
    default : begin
              y=3'bxxx;
              i=1'bx;
              end
    endcase
    end
    
    assign func=y;
    assign opB=i;
endmodule
