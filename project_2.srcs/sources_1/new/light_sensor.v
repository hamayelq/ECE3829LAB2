`timescale 1ns / 1ps

module light_sensor(
    input data,
    input clk_10hz, //10Hz for 16 cycles of SCLK
    input reset,
    input SCLK,
    input col1,
    input col2
    );

    reg [15:0] lightData;
    reg [3:0]  cnt;

    always @ (posedge SCLK, posedge reset)
        if(cnt != 4'b1111 && clk_10hz == 0)
            begin   //shift the input data into lightData
                cnt <= cnt + 1'b1;
                lightData = {lightData[14:0], data};
            end
        else if(clk_10hz == 1)  //send data to seven segment and color display at 1
            begin
                count <= 4'b0000;
                col1 <= lightData[12:9];
                col2 <= lightData[8:5];
            end
        else if(reset)  //remove/reset data if reset
            begin
                count <= 4'b0000;
                lightData <= 16'b0;
            end
        
endmodule