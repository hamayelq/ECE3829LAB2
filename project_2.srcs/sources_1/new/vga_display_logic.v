`timescale 1ns / 1ps

module vga_display_logic (
    input [2:0] SEL ,
    output hsync,
    output vsync,
    input clk,
    input [10:0] hcount,
    input [10:0] vcount,

    output wire [3:0] R,
    output wire [3:0] G,
    output wire [3:0] B
    );

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

    // Display character 'F' 0x46 on ASCII table
    wire [11:0] addr;
    wire [7:0] data;
    wire [11:0] TEXT;
    
    wire [3:0] text_row;
    wire text_col;
    assign text_row = vcount % 16;
    assign text_col = hcount % 8;
    assign addr = {8'h46, text_row};
    assign TEXT = (data[text_col] == 1) ? WHITE : BLACK;

    // high level state
    assign RGB = (blank) ? BLACK : state;
    assign state = 
            (SEL == 3'b000) ? BLUE :
            (SEL == 3'b001) ? (yellowOrange) ? ORANGE : YELLOW :
            (SEL == 3'b010) ? (hcount <= 128 && vcount >= 352) ? GREEN : BLACK :
            (SEL == 3'b011) ? (hcount >= 608 && vcount >= 448) ? WHITE : BLACK :
            (SEL == 3'b100) ? (hcount >= 316 && hcount <= 324 &&
                               vcount >= 232 && vcount <= 248) ? TEXT : BLACK : BLACK;
     
    // RGB color assignment                        
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

rom_4kx8 font(
    .clk(clk),
    .addr(addr),
    .data(data)
);

endmodule