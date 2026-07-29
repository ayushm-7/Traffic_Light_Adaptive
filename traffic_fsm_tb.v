`timescale 1ns/1ps

module traffic_system_tb;

reg clk;
reg reset;
reg [1:0] vehicle_density;

wire red;
wire yellow;
wire green;

traffic_system_top uut(

    .clk(clk),
    .reset(reset),

    .vehicle_density(vehicle_density),

    .red(red),
    .yellow(yellow),
    .green(green)

);

// Clock
always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;
    vehicle_density = 2'b00;

    #20;
    reset = 0;

    vehicle_density = 2'b00;
    #200;

    vehicle_density = 2'b01;
    #300;

    vehicle_density = 2'b10;
    #500;

    vehicle_density = 2'b00;
    #300;

    $finish;

end

endmodule
