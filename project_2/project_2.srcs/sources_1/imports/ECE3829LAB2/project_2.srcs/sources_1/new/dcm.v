`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/21/2020 10:02:56 AM
// Design Name: 
// Module Name: dcm
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


module dcm(
    input clk_fpga,
    input reset,
    output lockled,
    output clktwenty5
    );
    
    wire clk_10M;
    
    //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

  clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
    // Status and control signals
    .reset(reset), // input reset
    .locked(lock_led),       // output locked
   // Clock in ports
    .clk_in1(clk_fpga));      // input clk_in1
// INST_TAG_END ------ End INSTANTIATION Template ---------

    
endmodule
