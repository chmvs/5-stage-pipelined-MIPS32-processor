`timescale 1ns / 1ps

module memory(
    input clk,
    input [31:0]addr,
    input [31:0]wrdata,
    input wren,
    output [31:0]rddata
    );
    
    reg [31:0] mem [65535:0];
    
    initial begin
    mem[0]<= 32'b00010000001000100000100000000000;
    end
    
    always@(negedge clk)
    begin
    if(wren) mem[addr]<=wrdata;
    end   
    assign rddata=mem[addr];
endmodule
