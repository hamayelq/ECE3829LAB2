`timescale 1ns / 1ps

module vga_display_logic (
    input [1:0] SEL ,
    output hsync,
    output vsync,
    input clk,
    input [10:0] hcount,
    input [10:0] vcount,

    output wire [3:0] R,
    output wire [3:0] G,
    output wire [3:0] B
    );

    wire [10:0] hcount;
    wire [10:0] vcount;
    wire [11:0] RGB;
    wire [11:0] state;
    wire reset;
    wire blank;

    wire yellowOrange = hcount[4];
    
    // Color definitions
    parameter BLACK   = 12'h000;
    parameter WHITE   = 12'hfff;
    parameter RED     = 12'hf00;
    parameter GREEN   = 12'h0f0;
    parameter BLUE    = 12'h00f;
    parameter YELLOW  = 12'hff0;
    parameter MAGENTA = 12'hf0f;
    parameter TEAL    = 12'h0ff;
    parameter ORANGE  = 12'hfa0; 

    assign RGB = (blank) ? BLACK : state;
    assign state = 
            (SEL == 2'b00) ? BLUE :
            (SEL == 2'b01) ? (yellowOrange) ? ORANGE : YELLOW :
            (SEL == 2'b10) ? (hcount <= 128 && vcount >= 352) ? GREEN : BLACK :
                             (hcount >= 608 && vcount >= 448) ? WHITE : BLACK;
                            
    assign R = RGB[11:8];
    assign G = RGB[7:4];
    assign B = RGB[3:0];

vga_controller_640_60 vga(
    .rst(reset), 
    .pixel_clk(clk), 
    .HS(hsync), 
    .VS(vsync), 
    .hcount(hcount), 
    .vcount(vcount), 
    .blank(blank)
    );

endmodule
