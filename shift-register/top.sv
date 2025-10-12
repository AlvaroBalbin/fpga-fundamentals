module top
(
	input logic [3:0] KEY,
	input logic [9:0] SW,
	output logic [9:0] LEDR
);
	logic [5:0] bits_w;
	
	shiftRegister AVL420
	(	
		.Clock(KEY[0]),
		.Reset(~KEY[1]),
		.LeftCtrl(SW[6]),
		.LeftIn(SW[7]),
		.RightCtrl(SW[8]),
		.RightIn(SW[9]),
		.Bits(bits_w)
		
		
	);
	
	assign LEDR[5:0] = bits_w;
	assign LEDR[9:6] = 4'b0000;

endmodule