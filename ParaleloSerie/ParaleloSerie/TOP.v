module TOP (
           input clk, clr_n,                //clr eh para saber inicio do piso. 
			  input ldA, ldB, ldC, ldD,        //bit logico que habilita carga paralela
			  input [3:0] inA, inB, inC, inD,  //sinal de entrada reg
			  input transmit,                  // sinal que inicializa transmissão - liga os cont
			  output data,                     //saída do multi
			  output [1:0] QbitRX, QwrdRX,     //contagem de bit e de palavra 
			  output sent_n, received_n,         //sinais ativos em 0 
			  output [3:0]outA, outB, outC, outD//registradores de saída
			  );


TX TX (
      .clk(clk), 
		.clr_n(clr_n),
		.ld_A(ldA), 
		.ld_B(ldB), 
		.ld_C(ldC), 
		.ld_D(ldD),
		.A(inA),
		.B(inB),
		.C(inC),
		.D(inD),
		.transmit(transmit),
		.transmit_data(data),
		.sent_n(sent_n)
      );

RX RX (
      .clk(clk), 
		.clr_n(clr_n),
		.transmit(transmit),
		.data_RX(data),
		.A(outA), 
		.B(outB), 
		.C(outC), 
		.D(outD),
		.Qbit(QbitRX), 
		.Qwrd(QwrdRX),
		.received_n(received_n) 
      );

endmodule 