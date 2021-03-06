module RX (
          input clk, clr_n,
			 input transmit,
			 input data_RX,
			 output [3:0] A, B, C, D,
			 output [1:0] Qbit, Qwrd,
			 output received_n 
          );
			 
wire [3:0] out_demux;

wire [3:0] ena_SIPO;

wire EN;
wire TCbit, TCwrd;

DEMUX4 DEMUX4 (
              .I(data_RX),
				  .S0(Qwrd[0]), 
				  .S1(Qwrd[1]),
				  .O(out_demux) 
              );
				  
SIPOReg SIPORegA (
                 .clk(clk), 
					  .clr_n(clr_n), 
					  .ena(ena_SIPO[0]),
					  .data_in(out_demux[0]),
					  .data_out(A)
                 );
					  
SIPOReg SIPORegB (
                 .clk(clk), 
					  .clr_n(clr_n), 
					  .ena(ena_SIPO[1]),
					  .data_in(out_demux[1]),
					  .data_out(B)
                 );
					  
SIPOReg SIPORegC (
                 .clk(clk), 
					  .clr_n(clr_n), 
					  .ena(ena_SIPO[2]),
					  .data_in(out_demux[2]),
					  .data_out(C)
                 );
					  
SIPOReg SIPORegD (
                 .clk(clk), 
					  .clr_n(clr_n), 
					  .ena(ena_SIPO[3]),
					  .data_in(out_demux[3]),
					  .data_out(D)
                 );
					  
decoder4 decoder4 (
                  .A(Qwrd[0]), 
						.B(Qwrd[1]),
					   .EN(EN),
					   .O(ena_SIPO)
                );
					 

D_FF DFF1 (
			.d(1'b1), 
			.clk(transmit), 
			.clr_n(received_n), 
			.q(EN)
			);

cnt4 bit_cnt (
             .clk(clk), 
				 .clr_n(received_n), 
				 .EN(EN),
				 .Q(Qbit),
				 .TC(TCbit)
				 );
				 
cnt4 bit_wrd (
             .clk(clk), 
				 .clr_n(received_n), 
				 .EN(TCbit),
				 .Q(Qwrd),
				 .TC(TCwrd)
				 );
				 
JK_FF JKFF1 (
				.j(1'b1), 
				.k(TCwrd & TCbit), 
				.clk(clk), 
				.clr_n(clr_n),
				.q(received_n)
				);

endmodule 