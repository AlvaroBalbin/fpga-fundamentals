module shiftRegister
(

	input logic Clock,
	input logic LeftCtrl,
	input logic LeftIn,
	input logic RightCtrl,
	input logic RightIn,

	input logic Reset,
	output logic [5:0] Bits

);

	logic [5:0] nextBits; 

	always_comb
	begin 
	if (LeftCtrl)
		// do left control logic
		nextBits = {Bits[4:0], LeftIn};
	else if (RightCtrl)
		// do right control logic
		nextBits = {RightIn, Bits[5:1]};
	else
		nextBits = Bits;
	end
	
	always_ff @ (negedge Clock)
	begin 
		if (Reset)
			Bits <= '0;
		else 
			Bits <= nextBits;
		
	end

endmodule
