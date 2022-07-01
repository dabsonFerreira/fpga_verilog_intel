`timescale 1ns/100ps
module FSM_tb();

wire [1:0] out,carros_av1, carros_av2;
wire pedestre_av1, pedestre_av2;

reg clk, rst;
reg [1:0] in;

initial
fork
	rst = 1'b1;
	clk = 1'b0;
	in = 2'b11;
	
	#50 rst = 1'b0;
	
	forever
		#10 clk = ~clk;
		
	#90      in = 2'b11;
	#500     in = 2'b10;
	
	#1000    in = 2'b00;
	#1500    in = 2'b01;
	
join

semaforo DUT   (
					.rst(rst), 
					.clk(clk),
					.corInicial_Carros_av1(in),// 00 vermelho com c2 verde    //10 amarelho  
																//  01 vermelho com c2 amarelo  //11 verde
					.out(out),
					
					//======//=======// aki estão as luzes que recebem a entrada

					.c1(carros_av1), 
					.c2(carros_av2),
					.p1(pedestre_av1), 
					.p2(pedestre_av2) // só tem 2 posições => 1 verde 0 vermelho
								
					);

endmodule 