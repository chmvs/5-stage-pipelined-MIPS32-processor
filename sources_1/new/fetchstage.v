`timescale 1ns / 1ps

module fetchstage(
input [31:0]PC,
input [31:0]INS34,ins,
input cond34,clk,halt_f,
input [31:0]ALUout34,
input rst,
output reg [31:0]INS12,NPC12,
output [31:0]addr
    );
    //wire [31:0]ins;
    //wire [31:0]addr;
    parameter BEQZ=6'b001100, BNEQZ=6'b001101;
    assign addr=(((INS34[31:26]==BEQZ)&&(cond34==1))||((INS34[31:26]==BNEQZ)&&(cond34==0)))?ALUout34:PC;
    //assign addr=PC;
    //memory m(.clk(clk),.addr(addr),.wrdata(31'b0),.wren(1'b0),.rddata(ins));
    always@(posedge clk or posedge rst)
    begin
    if(rst)
    begin
    INS12<=0;
    NPC12<=0;
    end
    else
    begin
    if(halt_f==0)
    begin
    INS12<=ins;
    if(((INS34[31:26]==BEQZ)&&(cond34==1))||((INS34[31:26]==BNEQZ)&&(cond34==0)))
    begin
    NPC12<=ALUout34+1;
 
    end
    else
    begin
    NPC12<=PC+1;

    
    end
    end
    end
    end
    
endmodule
