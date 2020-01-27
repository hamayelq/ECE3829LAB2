`timescale 1ns / 1ps

module vga_display_logic (
    input BLANK,
    input PRESS,
    input [3:0] PRESS_A,
    input [3:0] PRESS_B,
    input [1:0] SEL,
    input [10:0] horizontalc,
    input [10:0] verticalc,
    
    output reg [3:0] R,
    output reg [3:0] G,
    output reg [3:0] B
    );

    wire [6:0] SEG1;
    wire [6:0] SEG2;
    wire yellow&orange = verticalcount[4];

    //need to make a decoder module. how do we make this work?
    //basically converting a and b input to seven seg
    segment_decode(.switchChoice(PRESS_A), .SEG(SEG1));
    segment_decode(.switchChoice(PRESS_B), .SEG(SEG2));

    parameter BLACK = 12'b0000_0000_0000;
    parameter WHITE = 12'b1111_1111_1111;
    parameter RED =   12'b1111_0000_0000;
    parameter GREEN = 12'b0000_1111_0000;
    parameter BLUE =  12'b0000_0000_1111;
    parameter YELLOW = RED + GREEN;
    parameter PURPLE = RED + BLUE;
    parameter TEAL = GREEN + BLUE;
    parameter ORANGE = YELLOW + RED; 

    always @ (SEL)
        begin
            if (sel == 2'b00)   //blank screen or blue
                R = ZEROES;
                G = ZEROES;
                B = BLANK ? ZEROES : ONES;
                //R and G off, blue on unless blank
                //fill this out, kill me XDDDDD

                // if (BUTTON = 1)

            end
        end

        else if (sel == 2'b01) //horizontal lines
            begin
                R = BLANK ? ZEROES : ONES;  //red if not blank
                G = BLANK ? ZEROES :
                B = ZEROES; //this is going to make red and yellow not qquite yellow and orange
            end

        else if (sel == 2'b10) //black screen box
            begin
                R = BLANK ? ZEROES;
                (verticalc > ?? && horizontalc <= ?? ) ? ONES : ZEROES;
                G = BLANK ? ZEROES;
                (verticalc > ?? && horizontalc <= ?? ) ? ONES : ZEROES;
                B = BLANK ? ZEROES;
                (verticalc > ?? && horizontalc <= ?? ) ? ONES : ZEROES;
                //turn them on if they're in bottom right part to make white box

        else if (sel == 2'b11)  //green box
            begin
                R = BLANK ? ZEROES;
                (verticalc > ?? && horizontalc <= ?? ) ? ZEROES : ZEROES;
                G = BLANK ? ZEROES;
                (verticalc > ?? && horizontalc <= ?? ) ? ONES : ZEROES;
                B = BLANK ? ZEROES;
                (verticalc > ?? && horizontalc <= ?? ) ? ZEROES : ZEROES;
                //only turn on if in range of green box ayayayaay
