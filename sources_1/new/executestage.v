`timescale 1ns / 1ps

module executestage(
input clk,halt_f,rst,
input [2:0]type23,
input [31:0]INS23,NPC23,A23,B23,IMM23,
output reg [31:0]ALUout34,INS34,B34,
output reg [2:0]type34,
output reg cond34,branch_f
    );

parameter rr_alu=3'b000,ri_alu=3'b001,load=3'b010,store=3'b011,branch=3'b100,halt=3'b101;
wire [2:0]func;
wire IM_f;
wire [31:0]temp,t_out;

ALUdecode a(.opcode(INS23[31:26]),.func(func),.B(B23),.IMM(IMM23),.opB(temp));

ALU b(.opA(A23),.opB(temp),.func(func),.out(t_out));

always@(posedge clk or posedge rst)
begin
if(rst)
begin
ALUout34<=0;
INS34<=0;
B34<=0;
type34<=0;
cond34<=0;
branch_f<=0;
end
else
begin
if(halt_f==0)
begin
type34<=type23;
INS34<=INS23;
case(type23)
rr_alu,ri_alu : begin
                ALUout34<=t_out;
                branch_f<=0;
                end
load,store : begin
             ALUout34<=t_out;
             B34<=B23;
             branch_f<=0;
             end
branch : begin
         ALUout34<=NPC23+IMM23;
         cond34<=(A23==0);
         branch_f<=1;
         end              
endcase
end
end
end

endmodule