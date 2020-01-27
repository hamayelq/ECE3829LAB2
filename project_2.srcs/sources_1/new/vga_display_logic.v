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

    parameter ZEROES = 4'b0000;
    parameter ONES   = 4'b1111;

    always @ (SEL)
        begin
            if (sel == 2'b00)   //blank screen
            //fill this out, kill me XDDDDD
            end
        end

        else if (sel == 2'b01) //horizontal lines
            begin
                //turn on red and green for yellow
                