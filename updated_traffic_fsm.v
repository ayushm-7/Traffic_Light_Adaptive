`timescale 1ns/1ps
module updated_traffic_fsm(

    input wire clk,
    input wire reset,
    input wire timer_expired,
    input wire [1:0] vehicle_density,

    output reg [31:0] timer_limit,
    output reg red,
    output reg yellow,
    output reg green
);

// Timing constants
localparam LOW_TIME    = 5;
localparam MEDIUM_TIME = 10;
localparam HIGH_TIME   = 20;

// Density encoding
localparam LOW    = 2'b00,
           MEDIUM = 2'b01,
           HIGH   = 2'b10;

// State encoding
localparam GREEN  = 2'b00,
           YELLOW = 2'b01,
           RED    = 2'b10;

reg [1:0] current_state;
reg [1:0] next_state;

//------------------------------------------------------
// Timer selection
//------------------------------------------------------
always @(*) begin

    timer_limit = LOW_TIME;

    case(vehicle_density)
        LOW:     timer_limit = LOW_TIME;
        MEDIUM:  timer_limit = MEDIUM_TIME;
        HIGH:    timer_limit = HIGH_TIME;
    endcase

end

//------------------------------------------------------
// State register
//------------------------------------------------------
always @(posedge clk or posedge reset)
begin
    if(reset)
        current_state <= GREEN;
    else
        current_state <= next_state;
end

//------------------------------------------------------
// Next-state logic
//------------------------------------------------------
always @(*) begin

    case(current_state)

        GREEN:
            if(timer_expired)
                next_state = YELLOW;
            else
                next_state = GREEN;

        YELLOW:
            if(timer_expired)
                next_state = RED;
            else
                next_state = YELLOW;

        RED:
            if(timer_expired)
                next_state = GREEN;
            else
                next_state = RED;

        default:
            next_state = GREEN;

    endcase

end

//------------------------------------------------------
// Output logic
//------------------------------------------------------
always @(*) begin

    red    = 0;
    yellow = 0;
    green  = 0;

    case(current_state)

        GREEN:
            green = 1;

        YELLOW:
            yellow = 1;

        RED:
            red = 1;

    endcase

end

endmodule
