`timescale 1ns / 1ps

module registerWBstage(
input clk,branch_f,rst,
input [31:0]ALUout45,TLD45,INS45,
input [2:0]type45,
output reg halt_f,
output reg[31:0]data,
output reg [4:0]addr
    );
    parameter rr_alu=3'b000,ri_alu=3'b001,load=3'b010,store=3'b011,branch=3'b100,halt=3'b101;   
     //reg wren;
     //reg [31:0]addr,data;
    //registerblock re(.clk(clk),.rd1(5'b00000),.rd2(5'b00000),.wren(wren),.wraddr(addr),.wrdata(data));
 
     always@(posedge clk or posedge rst)
     begin
     if(rst)
     begin
     halt_f<=0;
     data<=0;
     addr<=0;
     end
     else
     begin
     //if(branch_f!=0) wren<=0;
     case(type45)
     rr_alu : begin
              addr<=INS45[15:11];
              data<=ALUout45;
              //wren<=1;
              end
     ri_alu : begin
              addr<=INS45[20:16];
              data<=ALUout45;
              //wren<=1;
              end 
     load : begin
              addr<=INS45[20:16];
              data<=TLD45;
              //wren<=1;
            end
     halt : begin
            halt_f<=1;
            //wren<=0;
            end
     //default : wren<=0;                       
     endcase
     end
     end    
endmodule
