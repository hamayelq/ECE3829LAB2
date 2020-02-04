module rom_4kx8(
    input clk,
    input [11:0] addr,
    output reg [7:0] data
    );

reg [7:0] rom [4095:0];  // 4kx8 read only RAM

initial
    $readmemh("rom_data.mem", rom);

always @ (posedge clk)
    data <= rom[addr];


endmodule