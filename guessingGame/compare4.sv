// comparator for a bit guessing game
// Alvaro Balbin ab4647
// secret = stored secret number
// guess  = current guess from switches

module compare4 (
    input  [3:0] secret,
    input  [3:0] guess,
    output       is_equal,
    output       is_greater,  // guess > secret
    output       is_less      // guess < secret
);

    assign is_equal   = (guess == secret);
    assign is_greater = (guess >  secret);
    assign is_less    = (guess <  secret);

endmodule
