`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2020 08:23:16 AM
// Design Name: 
// Module Name: lab2_top
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


module lab2_top(
    input clk_fpga,
    input [2:0] sw,
    output cs,
    input sdo,
    output sck,
    output [3:0] an,
    output [6:0] seg,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output hsync,
    output vsync,
    input reset
    );

    wire clk_25;
    wire locked;
    wire [7:0] light;

    clk_wiz_0 clk_main (
    // Clock out ports
    .clk_out1(clk_25),     // output clk_out1
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk_fpga));      // input clk_in1

    vga_display_logic vga_color_logic (
        .SEL(sw), 
        .clk(clk_25), 
        .hsync(hsync), 
        .vsync(vsync), 
        .R(R), 
        .G(G), 
        .B(B)
    );
    
    light_sensor sens(
        .clk_25M(clk_25), 
        .reset(reset), 
        .sdo(sdo), 
        .cs(cs), 
        .sck(sck), 
        .light(light)
        );
        
     wire [3:0] c, d; // Not connected
     assign c = {0};
     assign d = {0};   
     seven_seg seg1(
        .clk(clk_25),
        .A(light[3:0]),
        .B(light[7:4]),
        .C(c),
        .D(d),
        .ANODE(an),
        .SEG_TOP(seg)
     );
     
endmodule