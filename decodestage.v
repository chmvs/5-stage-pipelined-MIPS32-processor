`timescale 1ns / 1ps

module decodestage(
input clk,halt_f,rst,
input [31:0]INS12,NPC12,rs,rt,
output reg [31:0]INS23,NPC23,IMM23,A23,B23,
output reg [2:0] type23
    );
    
    parameter rr_alu=3'b000,ri_alu=3'b001,load=3'b010,store=3'b011,branch=3'b100,halt=3'b101;
    parameter LW=6'b000001, SW=6'b000010, ADD=6'b000011,SUB=6'b000100,AND=6'b000101,OR=6'b000110,MUL=6'b000111,SLT=6'b001000,ADDI=6'b001001,SUBI=6'b001010,SLTI=6'b001011,BEQZ=6'b001100,BNEQZ=6'b001101,HLT=6'b111111;
    //wire [31:0]rs,rt;
   //registerblock re(.A(rs),.B(rt),.clk(clk),.rd1(INS12[25:21]),.rd2(INS12[20:16]),.wren(1'b0),.wraddr(5'b00000),.wrdata(32'b0));
    always@(posedge clk or posedge rst)
    begin
    if(rst)
    begin
    INS23<=0;
    NPC23<=0;
    IMM23<=0;
    A23<=0;
    B23<=0;
    type23<=0;
    end
    else
    begin
    if(halt_f==0)
    begin
    if(INS12[25:21]==5'b00000) A23<=0;
    else A23<=rs;
    
    if(INS12[20:16]==5'b00000) B23<=0;
    else B23<=rt;
    
    NPC23<=NPC12;
    INS23<=INS12;
    IMM23<={{16{INS12[15]}},{INS12[15:0]}};
    
    case(INS12[31:26])
    ADD,SUB,AND,OR,SLT,MUL : type23<=rr_alu;
    ADDI,SUBI,SLTI : type23<=ri_alu;
    LW : type23<=load;
    SW : type23<=store;
    BNEQZ,BEQZ : type23<=branch;
    HLT : type23<=halt;
    default : type23<=halt;
    endcase  
    end
    end
    end
endmodule
