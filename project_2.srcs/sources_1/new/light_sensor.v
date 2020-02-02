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
    reg clk_1M;
    reg [4:0] clk1_counter;
    always @ (posedge clk_25M)
        begin
        clk_1M = (clk1_counter == 24) ? 1 : 0;
        if(clk1_counter == 25)
            clk1_counter = 0;
         else
            clk1_counter = clk1_counter + 1'b1;
        end
    
    // 10Hz clock divider
    reg clk_10H;
    reg [21:0] clk2_counter;
    always @ (posedge clk_1M)
        begin
        clk_10H = (clk2_counter == 2500000-1) ? 1 : 0;
        if(clk2_counter == 2500000)
            clk2_counter = 0;
        else
            clk2_counter = clk2_counter + 1'b1;            
        end
        
    assign cs = clk_10H;
    assign sck = clk_1M;
    
    reg [15:0] lightData;
    reg [3:0]  cnt;
    always @ (posedge sck, posedge reset)
        if(cnt != 4'b1111 && clk_1M == 0)
            begin   //shift the input data into lightData
                cnt <= cnt + 1'b1;
                lightData = {lightData[14:0], sdo};
            end
        else if(clk_1M == 1)  //send data to seven segment and color display at 1
            begin
                cnt <= 4'b0000;
            end
        else if(reset)  //remove/reset data if reset
            begin
                cnt <= 4'b0000;
                lightData <= 16'b0;
            end
    
    assign light = (clk_1M == 1)? lightData[12:5] : {0};
        
endmodule