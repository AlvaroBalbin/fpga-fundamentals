import InstructionSetPkg::*;

module ArithmeticLogicUnit
(
	input  eOperation Operation,
	input  sFlags     InFlags,
	output sFlags     OutFlags,
	input  signed [ImmediateWidth-1:0] InImm,
	input  signed [DataWidth-1:0] InSrc,
	input  signed [DataWidth-1:0] InDest,
	output logic signed [DataWidth-1:0] OutDest
);

	always_comb begin
		OutFlags = InFlags;

		case (Operation)

			ROL:     {OutFlags.Carry, OutDest} = {InSrc, InFlags.Carry};	
			NAND:    OutDest = ~(InSrc & InDest);

			LIL:	 OutDest = $signed(InImm);

			LIU: begin
				if (InImm[ImmediateWidth - 1] == 1)
					OutDest = {InImm[ImmediateWidth - 2:0], InDest[ImmediateHighStart - 1:0]};
				else if (InImm[ImmediateWidth - 1] == 0)	
					OutDest = $signed({InImm[ImmediateWidth - 2:0], InDest[ImmediateMidStart - 1:0]});
				else
					OutDest = InDest;	
			end

			LOAD:  OutDest = InSrc;
			STORE: OutDest = InDest;
			MOVE:  OutDest = InSrc;
			NOR:   OutDest = ~(InDest | InSrc);
			ROR:   {OutDest, OutFlags.Carry} = {InFlags.Carry, InSrc};
			
			ADC: begin
				logic [DataWidth:0] full_sum;
				full_sum = InSrc + InDest + InFlags.Carry;
				OutDest = full_sum[DataWidth-1:0];
				OutFlags.Carry = full_sum[DataWidth];

				// Zero flag
				if (OutDest == 0)
					OutFlags.Zero = 1;
				else
					OutFlags.Zero = 0;

				// Negative flag
				if (OutDest < 0)
					OutFlags.Negative = 1;
				else 
					OutFlags.Negative = 0;

				// Parity flag
				if (^OutDest == 0)
					OutFlags.Parity = 1;
				else
					OutFlags.Parity = 0;

				// Overflow flag
				if ((InSrc[DataWidth - 1] == InDest[DataWidth - 1]) &&
					(OutDest[DataWidth - 1] != InDest[DataWidth - 1]))
					OutFlags.Overflow = 1;
				else
					OutFlags.Overflow = 0;
			end
			
			SUB: begin
				OutDest = InDest - (InSrc + InFlags.Carry);

				// Carry flag
				if (InDest < (InSrc + InFlags.Carry))
					OutFlags.Carry = 1;
				else
					OutFlags.Carry = 0;
				
				// Zero flag
				if (OutDest == 0)
					OutFlags.Zero = 1;
				else
					OutFlags.Zero = 0;
				
				// Negative flag
				if (OutDest < 0)
					OutFlags.Negative = 1;
				else 
					OutFlags.Negative = 0;
				
				// Parity flag
				if (^OutDest == 0)
					OutFlags.Parity = 1;
				else
					OutFlags.Parity = 0;
				
				// Overflow flag
				if ((InDest[DataWidth - 1] != InSrc[DataWidth - 1]) && 
					(OutDest[DataWidth - 1] != InDest[DataWidth - 1]))
					OutFlags.Overflow = 1;
				else
					OutFlags.Overflow = 0;
			end
			
			DIV: begin
				if (InSrc == 0)
					OutDest = 0;
				else
					OutDest = $signed(InDest) / $signed(InSrc);

				if (OutDest == 0)
					OutFlags.Zero = 1;
				else
					OutFlags.Zero = 0;

				if (OutDest < 0)
					OutFlags.Negative = 1;
				else 
					OutFlags.Negative = 0;

				if (^OutDest == 0)
					OutFlags.Parity = 1;
				else
					OutFlags.Parity = 0;
			end
			
			MOD: begin
				if (InSrc == 0)
					OutDest = 0;
				else
					OutDest = $signed(InDest) % $signed(InSrc);

				if (OutDest == 0)
					OutFlags.Zero = 1;
				else
					OutFlags.Zero = 0;

				if (OutDest < 0)
					OutFlags.Negative = 1;
				else 
					OutFlags.Negative = 0;

				if (^OutDest == 0)
					OutFlags.Parity = 1;
				else
					OutFlags.Parity = 0;
			end

			MUL: begin
				OutDest = $signed(InDest) * $signed(InSrc);

				if (OutDest == 0)
					OutFlags.Zero = 1;
				else
					OutFlags.Zero = 0;
				
				if (OutDest < 0)
					OutFlags.Negative = 1;
				else 
					OutFlags.Negative = 0;
		
				if (^OutDest == 0)
					OutFlags.Parity = 1;
				else
					OutFlags.Parity = 0;
			end
			
			MUH: begin
				OutDest = ( { {DataWidth{InDest[DataWidth-1]}}, InDest } *
							{ {DataWidth{InSrc [DataWidth-1]}}, InSrc  } ) >> DataWidth;

				if (OutDest == 0)
					OutFlags.Zero = 1;
				else
					OutFlags.Zero = 0;
				 
				if (OutDest < 0)
					OutFlags.Negative = 1;
				else 
					OutFlags.Negative = 0;

				if (^OutDest == 0)
					OutFlags.Parity = 1;
				else
					OutFlags.Parity = 0;
			end

			default: OutDest = '0;
			
		endcase;
	end

endmodule
