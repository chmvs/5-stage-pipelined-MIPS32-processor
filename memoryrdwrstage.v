`timescale 1ns / 1ps

module memoryrdwrstage(
input clk,halt_f,branch_f,rst,
input [2:0]type34,
input [31:0]INS34,B34,ALUout34,data,
output reg [31:0]TLD45,INS45,ALUout45,
output  reg [2:0]type45
    );
    parameter rr_alu=3'b000,ri_alu=3'b001,load=3'b010,store=3'b011,branch=3'b100,halt=3'b101;
    //reg wren;
    //wire [31:0]data;
    //memory m(.clk(clk),.addr(ALUout34),.wrdata(B34),.wren(wren),.rddata(data));
    always@(posedge clk or posedge rst)
    begin
    if(rst)
    begin
    TLD45<=0;
    INS45<=0;
    ALUout45<=0;
    type45<=0;
    end
    else
    begin
    if(halt_f==0)
    begin
    type45<=type34;
    INS45<=INS34;
    case(type34)
    rr_alu,ri_alu : begin
                    ALUout45<=ALUout34;
                    //wren<=0;
                    end
    load : begin
           TLD45<=data;
           //wren<=0;
           end
   // store : if(branch_f==0) wren<=1;
   // default : wren<=0;
    endcase
    end
    end
    end
    
endmodule
