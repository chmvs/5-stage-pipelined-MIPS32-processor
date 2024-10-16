`timescale 1ns / 1ps

module ALU(
input [31:0]opA,opB,
input [2:0]func,
output [31:0]out
    );
    reg [31:0]y;
    always@(*)
    begin
    case(func)
    3'b001 : y=opA+opB;
    3'b010 : y=opA-opB;
    3'b011 : y=opA&opB;
    3'b100 : y=opA|opB;
    3'b101 : y=opA*opB;
    3'b110 : y=opA<opB;
    default :y=32'hxxxxxxxx;
    endcase
    end 
    
    assign out=y;
endmodule
