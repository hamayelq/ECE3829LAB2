`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hamayel Qureshi, Nam Tran
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
// Additional Comments: Module containing logic to display VGA screen. 
// 
//////////////////////////////////////////////////////////////////////////////////

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
    reg [10:0] hcount_d;
    reg [10:0] vcount_d;
    always @ (posedge clk)
        begin
        hcount_d <= hcount;
        vcount_d <= vcount;
        end
    
    wire [11:0] addr;
    wire [7:0] data;
    wire [11:0] TEXT;
    
    wire [3:0] text_row;
    wire [2:0] text_col;
    assign text_row = vcount[3:0] - 8;
    assign text_col = ~(hcount_d[2:0]);
//    assign addr = {8'h46, text_row};
    assign addr[3:0] = text_row;
    assign addr[11:4] = (hcount_d >= 288 && hcount_d <= 295) ? 8'h45 :
                        (hcount_d >= 296 && hcount_d <= 303) ? 8'h43 : 
                        (hcount_d >= 304 && hcount_d <= 311) ? 8'h45 :
                        (hcount_d >= 312 && hcount_d <= 319) ? 8'h20 : 
                        (hcount_d >= 320 && hcount_d <= 327) ? 8'h33 :
                        (hcount_d >= 328 && hcount_d <= 335) ? 8'h38 :
                        (hcount_d >= 336 && hcount_d <= 343) ? 8'h32 :
                        (hcount_d >= 344 && hcount_d <= 351) ? 8'h39 : 8'h00;
                        
    assign TEXT = (data[text_col] == 1) ? WHITE : BLACK;

    // high level state
    assign RGB = (blank) ? BLACK : state;
    assign state = 
            (SEL == 3'b000) ? BLUE :
            (SEL == 3'b001) ? (yellowOrange) ? ORANGE : YELLOW :
            (SEL == 3'b010) ? (hcount <= 128 && vcount >= 352) ? GREEN : BLACK :
            (SEL == 3'b011) ? (hcount >= 608 && vcount >= 448) ? WHITE : BLACK :
            (SEL == 3'b100) ? (hcount >= 288 && hcount <= 352 &&
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
