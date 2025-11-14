// top module for the guessing game
// Alvaro Balbin ab4647

module guessingGameTop (
    input  logic       CLOCK_50,
    input  logic [9:0] SW,                 // SW[3:0] = secret, SW[7:4] = guess
    input  logic [3:0] KEY,                // KEY0 = store, KEY1 = toggle reveal
    output logic [9:0] LEDR,               // LEDR[2:0] = result LEDs
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    logic [3:0] secret_reg;
    logic [3:0] guess;

    logic eq, gt, lt;
    logic reveal_on;

    initial reveal_on = 1'b0;

    assign guess = SW[7:4];

    always_ff @(negedge KEY[0]) begin
        secret_reg <= SW[3:0];
    end

    always_ff @(negedge KEY[1]) begin
        reveal_on <= ~reveal_on;
    end

    compare4 thecomparer (
        .secret     (secret_reg),
        .guess      (guess),
        .is_equal   (eq),
        .is_greater (gt),
        .is_less    (lt)
    );

    logic [25:0] slow_cnt;
    logic [6:0]  anim_leds;

    always_ff @(posedge CLOCK_50) begin
        slow_cnt <= slow_cnt + 1;
    end

    always_comb begin
        if (eq) begin
            case (slow_cnt[25:23])
                3'd0: anim_leds = 7'b0000001;
                3'd1: anim_leds = 7'b0000011;
                3'd2: anim_leds = 7'b0000111;
                3'd3: anim_leds = 7'b0001111;
                3'd4: anim_leds = 7'b0011111;
                3'd5: anim_leds = 7'b0111111;
                3'd6: anim_leds = 7'b1111111;
                default: anim_leds = 7'b0000000;
            endcase
        end else begin
            anim_leds = 7'b0000000;
        end
    end

    always_comb begin
        LEDR = 10'b0;
        LEDR[0] = eq;
        LEDR[1] = gt;
        LEDR[2] = lt;
        LEDR[9:3] = anim_leds;
    end

    logic [6:0] hex_guess;
    logic [6:0] hex_secret;

    seven_seg_hex u_guess (
        .hex_in (guess),
        .seg    (hex_guess)
    );

    seven_seg_hex u_secret (
        .hex_in (secret_reg),
        .seg    (hex_secret)
    );

    assign HEX0 = hex_guess;
    assign HEX1 = (reveal_on) ? hex_secret : 7'b1111111;

    assign HEX2 = 7'b1111111;
    assign HEX3 = 7'b1111111;
    assign HEX4 = 7'b1111111;
    assign HEX5 = 7'b1111111;

endmodule
