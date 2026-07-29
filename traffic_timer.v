`timescale 1ns/1ps
module traffic_timer(

    input wire clk,
    input wire reset,
    input wire [31:0] timer_limit,

    output reg timer_expired
);

reg [31:0] counter;

always @(posedge clk or posedge reset)
begin

    if(reset)
        counter <= 0;

    else if(counter >= timer_limit-1)
        counter <= 0;

    else
        counter <= counter + 1;

end

always @(posedge clk or posedge reset)
begin

    if(reset)
        timer_expired <= 0;

    else if(counter >= timer_limit-1)
        timer_expired <= 1;

    else
        timer_expired <= 0;

end

endmodule
