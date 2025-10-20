module ProgramCounter (  //BA850 eh2355 nn587 ab4647
    input  logic              Clock,
    input  logic              Reset,
    input  logic signed [15:0] LoadValue,
    input  logic              LoadEnable,
    input  logic signed [8:0]  Offset,
    input  logic              OffsetEnable,
    output logic signed [15:0] CounterValue
);
 
    // Internal next-state register
    logic signed [15:0] NextCounterValue;
 
    // Sequential process: update counter on clock edge
    always_ff @(posedge Clock) begin
        if (Reset) begin
            CounterValue <= 16'sd0;   // synchronous reset
        end else begin
            CounterValue <= NextCounterValue;
        end
    end
 
    // Combinational process: compute next state
    always_comb begin
        // Default: increment
        NextCounterValue = CounterValue + 16'sd1;
 
        if (LoadEnable) begin
            NextCounterValue = LoadValue;
        end else if (OffsetEnable) begin
            NextCounterValue = CounterValue + Offset;
        end
        // Reset handled in sequential block
    end
 
endmodule