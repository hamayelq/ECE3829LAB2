`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2020 09:13:40 AM
// Design Name: 
// Module Name: lab2testbench
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


module lab2testbench();
reg clk,reset;
reg [1:0] sw;
wire [3:0] R, G, B;
wire hsync, vsync;

initial begin
reset = 1'b1;
clk = 1'b0;
#5;
reset = 1'b0;
#10;
sw = 2'b01;
#10;
sw = 2'b10;
end

always #5 clk = ~clk;

lab2_top top(.clk_fpga(clk), .sw(sw), .R(R), .G(G), .B(B), .hsync(hsync), .vsync(vsync));

endmodule
