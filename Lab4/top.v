`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2016 11:37:49 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input PBen,
    input Clk,
    output [3:0] OUT,
    output [1:0] Cout,    
    input PBrst
    );
    
Moore Moore (
    .CLK(CLK),
    .RST(PBrst),
    .OUT(OUT),
    .Cout(Cout)
    );
    
One_shot One_shot (
    .CLK(CLK),
    .EN(PBen)
    );
endmodule
