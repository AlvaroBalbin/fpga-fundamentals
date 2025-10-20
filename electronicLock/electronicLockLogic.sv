module electronicLockLogic
(
  input  CLOCK_50,
  input  [9:0] SW,
  input  [3:0] KEY,
  output [9:0] LEDR,
  output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

  logic [3:0] nKEY;
  logic tick;
  logic pressed;
  logic [1:0] keyVal;

  assign nKEY = ~KEY;

  typedef enum logic [2:0] { Start, OneCorrect, TwoCorrect, ThreeCorrect, Unlocked } eState;
  eState currentState, nextState;

  slowClock #(26) U0(.Clock(CLOCK_50), .Reset(SW[9]), .Pulse(tick));

  always_comb begin
    pressed = |nKEY;
    unique case (1'b1)
      nKEY[0]: keyVal = 2'b00;
      nKEY[1]: keyVal = 2'b01;
      nKEY[2]: keyVal = 2'b10;
      nKEY[3]: keyVal = 2'b11;
      default: keyVal = 2'b00;
    endcase
  end

  wire [1:0] key0 = SW[1:0];
  wire [1:0] key1 = SW[3:2];
  wire [1:0] key2 = SW[5:4];
  wire [1:0] key3 = SW[7:6];

  always_ff @(posedge tick or posedge SW[9]) begin
    if (SW[9])
      currentState <= Start;
    else
      currentState <= nextState;
  end

  always_comb begin
    nextState = currentState;
    if (SW[9])
      nextState = Start;
    else begin
      unique case (currentState)
        Start:        if (pressed) nextState = (keyVal == key0) ? OneCorrect   : Start;
        OneCorrect:   if (pressed) nextState = (keyVal == key1) ? TwoCorrect   : Start;
        TwoCorrect:   if (pressed) nextState = (keyVal == key2) ? ThreeCorrect : Start;
        ThreeCorrect: if (pressed) nextState = (keyVal == key3) ? Unlocked     : Start;
        Unlocked:     if (pressed) nextState = Start;
        default:      nextState = Start;
      endcase
    end
  end

  always_comb begin
    LEDR = 10'b0;
    case (currentState)
      Start:        LEDR[0] = 1'b0;
      OneCorrect:   LEDR[0] = 1'b1;
      TwoCorrect:   LEDR[1:0] = 2'b11;
      ThreeCorrect: LEDR[2:0] = 3'b111;
      Unlocked:     LEDR[3:0] = 4'b1111;
      default:      LEDR = 10'b0;
    endcase
  end

  always_comb begin
    if (SW[8]) begin
      HEX5 = 7'b0000110;
      HEX4 = 7'b0000110;
      HEX3 = 7'b0000110;
      HEX2 = 7'b1111111;
      HEX1 = 7'b1111111;
      HEX0 = 7'b1111111;
    end else if (currentState == Unlocked) begin
      HEX5 = 7'b1000000;
      HEX4 = 7'b0001100;
      HEX3 = 7'b0000110;
      HEX2 = 7'b0101011;
      HEX1 = 7'b1111111;
      HEX0 = 7'b1111111;
    end else begin
      HEX5 = 7'b1000110;
      HEX4 = 7'b1000111;
      HEX3 = 7'b1000000;
      HEX2 = 7'b0010010;
      HEX1 = 7'b0000110;
      HEX0 = 7'b0100001;
    end
  end

endmodule
