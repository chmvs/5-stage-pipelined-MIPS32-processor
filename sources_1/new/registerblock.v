`timescale 1ns / 1ps

module registerblock(
output [31:0]A,
output [31:0]B,
output [31:0]temp,
input clk,
input [4:0]rd1,
input [4:0]rd2,
input wren,
input [4:0] wraddr,
input [31:0]wrdata);
reg [31:0] RAM [31:0];
 initial begin
 RAM[1]<=32'b1000;
 RAM[2]<=32'b11;
 //RAM[1]<=32'b00000000000000000000000000000001;
 end
always@(negedge clk)
begin
if(wren)
RAM[wraddr]<=wrdata;
end 
assign temp=RAM[1];
assign A=(rd1==0)?0:RAM[rd1];
assign B=(rd2==0)?0:RAM[rd2];

endmodule
