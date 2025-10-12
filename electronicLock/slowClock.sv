module slowClock #(parameter N = 26)
(
  input  logic Clock,
  input  logic Reset,
  output logic Pulse
);

  logic [N-1:0] Count;

  always_ff @(posedge Clock, posedge Reset)
  begin
    if (Reset)
    begin
      Count <= 0;
      Pulse <= 0;
    end
    else
    begin
      Count <= Count + 1;
      Pulse <= ~|Count;
    end
  end

endmodule
