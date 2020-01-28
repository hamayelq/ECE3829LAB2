`timescale 1ns / 1ps

module vga_display_logic (
    input [1:0] SEL ,
    output hsync,
    output vsync,
    input clk,
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

//    always @ (SEL, blank)
//        case(SEL)
//            2'b00: 
//            2'b01:
//            2'b10:
//            2'b11:
//            begin
                    
//            end
   
    
    assign RGB = (blank) ? BLACK : state;
    assign state = (SEL == 2'b00) ? BLUE : (SEL == 2'b01) ? ORANGE : BLACK;
    
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

//    always @ (SEL)
//        begin
//            if (sel == 2'b00)   //blank screen or blue
//                R = ZEROES;
//                G = ZEROES;
//                B = BLANK ? ZEROES : ONES;
//                //R and G off, blue on unless blank
//                //fill this out, kill me XDDDDD

//                // if (BUTTON = 1)

//            end
//        end

//        else if (sel == 2'b01) //horizontal lines
//            begin
//                R = BLANK ? ZEROES : ONES;  //red if not blank
//                G = BLANK ? ZEROES :
//                B = ZEROES; //this is going to make red and yellow not qquite yellow and orange
//            end

//        else if (sel == 2'b10) //black screen box
//            begin
//                R = BLANK ? ZEROES;
//                (vsync > ?? && hsync <= ?? ) ? ONES : ZEROES;
//                G = BLANK ? ZEROES;
//                (vsync > ?? && hsync <= ?? ) ? ONES : ZEROES;
//                B = BLANK ? ZEROES;
//                (vsync > ?? && hsync <= ?? ) ? ONES : ZEROES;
//                //turn them on if they're in bottom right part to make white box

//        else if (sel == 2'b11)  //green box
//            begin
//                R = BLANK ? ZEROES;
//                (vsync > ?? && hsync <= ?? ) ? ZEROES : ZEROES;
//                G = BLANK ? ZEROES;
//                (vsync > ?? && hsync <= ?? ) ? ONES : ZEROES;
//                B = BLANK ? ZEROES;
//                (vsync > ?? && hsync <= ?? ) ? ZEROES : ZEROES;
//                //only turn on if in range of green box ayayayaay

endmodule