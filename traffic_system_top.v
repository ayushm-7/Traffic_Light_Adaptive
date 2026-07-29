`timescale 1ns/1ps
module traffic_system_top(

    input wire clk,
    input wire reset,
    input wire [1:0] vehicle_density,

    output wire red,
    output wire yellow,
    output wire green

);

wire timer_expired;
wire [31:0] timer_limit;

//-------------------------------------
// Timer
//-------------------------------------
traffic_timer TIMER_INST(

    .clk(clk),
    .reset(reset),
    .timer_limit(timer_limit),
    .timer_expired(timer_expired)

);

//-------------------------------------
// FSM
//-------------------------------------
updated_traffic_fsm FSM_INST(

    .clk(clk),
    .reset(reset),

    .timer_expired(timer_expired),
    .vehicle_density(vehicle_density),

    .timer_limit(timer_limit),

    .red(red),
    .yellow(yellow),
    .green(green)

);

endmodule
