`timescale 1ns / 1ps

module light_sensor(
    input clk_25M, //10Hz for 16 cycles of SCLK
    input reset,
    input sdo,
    output cs,
    output sck,
    output wire [7:0] light
    );
    
    // 1MHz clock divider
    reg [4:0] clk1_counter;
    always @ (posedge clk_25M)
        begin
        if(clk1_counter == 24)
            clk1_counter <= 0;
         else
            clk1_counter <= clk1_counter + 1'b1;
        end
    
    // sck is 1Mhz
    assign sck = (clk1_counter >= 12 && clk1_counter < 24) ? 1 : 0;
    
    // 10Hz clock divider
    reg [16:0] clk2_counter;
    always @ (posedge sck)
        begin
        if(clk2_counter == 999999)
            clk2_counter <= 0;
        else
            clk2_counter = clk2_counter + 1'b1;            
        end

    // cs low for 16 cycles, high for the rest        
    assign cs = (clk2_counter <= 16) ? 1'b0 : 1'b1;
    
    reg [15:0] lightData;
    always @ (posedge sck, posedge reset)
        begin
            if(~cs)
            begin
                lightData = lightData << 1;
                lightData[0] <= sdo;
            end
        if(reset)  //remove/reset data if reset
            lightData <= 16'b0;
        end
        
    assign light = lightData[11:4];
        
endmodule