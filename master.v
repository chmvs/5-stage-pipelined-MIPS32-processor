module master(input clk1,input clk2,input rst,output [31:0]test,output [31:0]test2,output [31:0]test3);

reg [31:0]PC;
wire halt_f,branch_f;
wire [31:0]INS12,NPC12;

wire [31:0]INS23,NPC23,A23,B23,IMM23;
wire [2:0]type23;

wire [31:0]ALUout34,INS34,B34;
wire [2:0]type34;
wire cond34;

wire [31:0]TLD45,ALUout45,INS45;
wire [2:0]type45;

reg [31:0]addr_mem;

wire [4:0]addr_reg;

wire [31:0]addr_fetch,rddata_mem,wrdata_reg,rs,rt;

reg wren_mem,wren_reg;

//initial begin
//PC<=0;
//end

parameter rr_alu=3'b000,ri_alu=3'b001,load=3'b010,store=3'b011,branch=3'b100,halt=3'b101;
parameter LW=6'b000001, SW=6'b000010, ADD=6'b000011,SUB=6'b000100,AND=6'b000101,OR=6'b000110,MUL=6'b000111,SLT=6'b001000,ADDI=6'b001001,SUBI=6'b001010,SLTI=6'b001011,BEQZ=6'b001100,BNEQZ=6'b001101,HLT=6'b111111;
    

fetchstage fetch(.rst(rst),.clk(clk1),.PC(PC),.INS34(INS34),.cond34(cond34),.halt_f(halt_f),.ALUout34(ALUout34),.INS12(INS12),.NPC12(NPC12),.ins(rddata_mem),.addr(addr_fetch));

decodestage decode(.rst(rst),.clk(clk2),.halt_f(halt_f),.INS12(INS12),.NPC12(NPC12),.INS23(INS23),.NPC23(NPC23),.IMM23(IMM23),.A23(A23),.B23(B23),.type23(type23),.rs(rs),.rt(rt));

executestage execute(.rst(rst),.clk(clk1),.halt_f(halt_f),.branch_f(branch_f),.type23(type23),.INS23(INS23),.NPC23(NPC23),.A23(A23),.B23(B23),.IMM23(IMM23),.ALUout34(ALUout34),.INS34(INS34),.B34(B34),.type34(type34),.cond34(cond34));

memoryrdwrstage memrdwr(.rst(rst),.clk(clk2),.halt_f(halt_f),.branch_f(branch_f),.type34(type34),.INS34(INS34),.B34(B34),.ALUout34(ALUout34),.TLD45(TLD45),.INS45(INS45),.ALUout45(ALUout45),.type45(type45),.data(rddata_mem));

registerWBstage regWB(.rst(rst),.clk(clk1),.halt_f(halt_f),.branch_f(branch_f),.ALUout45(ALUout45),.INS45(INS45),.TLD45(TLD45),.type45(type45),.data(wrdata_reg),.addr(addr_reg));

memory m(.clk(clk1),.addr(addr_mem),.wrdata(B34),.wren(wren_mem),.rddata(rddata_mem));

registerblock re(.temp(test),.A(rs),.B(rt),.clk(clk1),.rd1(INS12[25:21]),.rd2(INS12[20:16]),.wren(wren_reg),.wraddr(addr_reg),.wrdata(wrdata_reg));


//assign temp=addr_fetch;
//CONTROL PATH

always@(posedge clk1 or posedge rst)
begin
if(rst)
begin
PC<=32'b0;
addr_mem<=0;
wren_mem<=0;
wren_reg<=0;
end
else
begin
if(branch_f!=0) wren_reg<=0;
case(type45)
     rr_alu : wren_reg<=1;
     ri_alu : wren_reg<=1;
     load : wren_reg<=1;
     halt : wren_reg<=0;
     default : wren_reg<=0;                       
     endcase
addr_mem<=addr_fetch;
wren_mem<=0;
    if(halt_f==0)
    begin
    if(((INS34[31:26]==BEQZ)&&(cond34==1))||((INS34[31:26]==BNEQZ)&&(cond34==0)))
    begin
    PC<=ALUout34+1;
    end
    else
    begin
    PC<=PC+1;
    
    end
    end
    end
    end
    
    always@(posedge clk2)
    begin
    if(rst)
    begin
    PC<=0;
    addr_mem=0;
    wren_mem<=0;
    wren_reg<=0;
    end
    else
    begin
    wren_mem<=0;
    addr_mem<=ALUout34;
    if(halt_f==0)
    begin
    case(type34)
    rr_alu,ri_alu : wren_mem<=0;
    load : wren_mem<=0;
    store : if(branch_f==0) wren_mem<=1;
    default : wren_mem<=0;
    endcase
    end
    end
    end
    
    
    assign test2=rs;
    assign test3=INS12;
endmodule