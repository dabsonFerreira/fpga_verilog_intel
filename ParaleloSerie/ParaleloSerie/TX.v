module TX (
          input clk, clr_n,
			 input ld_A, ld_B, ld_C, ld_D,
			 input [3:0] A, B, C, D,
			 input transmit,
			 output transmit_data,
			 output sent_n 
			 );

wire Shift_enable;

wire outA, outB, outC, outD;
			 
PISOReg PISO_A (
               .clk(clk), 
					.clr_n(clr_n), 
					.load(ld_A), 
					.sh_ena(Shift_enable),
					.data_in(A),
					.data_out(outA)
               );
					
PISOReg PISO_B (
               .clk(clk), 
					.clr_n(clr_n), 
					.load(ld_B), 
					.sh_ena(Shift_enable),
					.data_in(B),
					.data_out(outB)
               );
					
PISOReg PISO_C (
               .clk(clk), 
					.clr_n(clr_n), 
					.load(ld_C), 
					.sh_ena(Shift_enable),
					.data_in(C),
					.data_out(outC)
               );
					
PISOReg PISO_D (
               .clk(clk), 
					.clr_n(clr_n), 
					.load(ld_D), 
					.sh_ena(Shift_enable),
					.data_in(D),
					.data_out(outD)
               );

wire [1:0] Qwrd, Qbit;
wire TCbit, TCwrd;
					
MUX4 MUX4 (
           .I0(outA), 
			  .I1(outB), 
			  .I2(outC), 
			  .I3(outD),
			  .S0(Qwrd[0]), 
			  .S1(Qwrd[1]),
			  .Z(transmit_data)
           );
			  
D_FF DFF1 (
				.d(1'b1), 
				.clk(transmit), 
				.clr_n(sent_n), 
				.q(Shift_enable)
				);
				
cnt4 cnt_bit(
				 .clk(clk), 
				 .EN(Shift_enable), 
				 .clr_n(sent_n),
				 .Q(Qbit),
				 .TC(TCbit)
				);
				
cnt4 cnt_wrd(
				 .clk(clk), 
				 .EN(TCbit), 
				 .clr_n(sent_n),
				 .Q(Qwrd),
				 .TC(TCwrd)
				);
				
JK_FF JKFF2 (
				.j(1'b1), 
				.k(TCwrd & TCbit), 
				.clk(clk), 
				.clr_n(clr_n),
				.q(sent_n)
				);

endmodule 