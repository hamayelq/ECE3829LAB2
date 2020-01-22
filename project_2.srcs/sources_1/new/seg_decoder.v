`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/21/2020 09:05:15 AM
// Design Name: 
// Module Name: seg_decoder
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


module seg_decoder(
    input [3:0] switchChoice,
    output reg [6:0] SEG
    );
    
             
    parameter display0 = 7'b1000000;
    parameter display1 = 7'b1111001;
    parameter display2 = 7'b0100100;
    parameter display3 = 7'b0110000;
    parameter display4 = 7'b0011001;
    parameter display5 = 7'b0010010;
    parameter display6 = 7'b0000010;
    parameter display7 = 7'b1111000;
    parameter display8 = 7'b0000000;
    parameter display9 = 7'b0010000;
    parameter displayA = 7'b0001000;
    parameter displayB = 7'b0000011;
    parameter displayC = 7'b1000110;
    parameter displayD = 7'b0100001;
    parameter displayE = 7'b0000110;
    parameter displayF = 7'b0001110;
    
    always @(switchChoice)
        begin

            case(switchChoice)
                4'b0000: SEG = display0;
                4'b0001: SEG = display1;
                4'b0010: SEG = display2;
                4'b0011: SEG = display3;
                4'b0100: SEG = display4;
                4'b0101: SEG = display5;
                4'b0110: SEG = display6;
                4'b0111: SEG = display7;
                4'b1000: SEG = display8;
                4'b1001: SEG = display9;
                4'b1010: SEG = displayA;
                4'b1011: SEG = displayB;
                4'b1100: SEG = displayC;
                4'b1101: SEG = displayD;
                4'b1110: SEG = displayE;
                4'b1111: SEG = displayF;
            endcase
        end
    
endmodule
