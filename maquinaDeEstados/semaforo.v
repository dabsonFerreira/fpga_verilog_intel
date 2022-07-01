module semaforo(
					input rst, clk,
					input [1:0] corInicial_Carros_av1,// 00 vermelho com c2 verde    //10 amarelho  
																//  01 vermelho com c2 amarelo  //11 verde
					output reg [1:0] out,
					
					//======//=======// aki estão as luzes que recebem a entrada

					output reg [1:0] c1, c2,
					output reg p1, p2 // só tem 2 posições => 1 verde 0 vermelho
								
					);

reg a_verde, a_amarelo, a_vermelho;	// valor 0 ou 1. é 1 se terminou a respectiva contagem
					
parameter entrada0 = 2'b11, entrada1 = 2'b10, entrada2 = 2'b00, entrada3 = 2'b01;
					
reg [5:0]verde; reg [4:0] vermelho; reg [3:0] amarelo;// contadores
				
reg [1:0] state; // corresponde ao estado de todos os semáforos num dado instante



parameter s0 = 2'd0 , s1 = 2'd1, s2 = 2'd2, s3 = 2'd3;

// transição dos estados - depende de clok

always @ (posedge clk or posedge rst)
begin
	
	if (rst)
	
	begin
		state <= s0;
		c1 = 2'd0; c2 = c1; p1 = 1'd0; p2 = p1;//perpetuando o valor 0 para todos;
	
	end
		
	else 
	begin
			case (corInicial_Carros_av1)
			
				
				entrada0:
				
					state = s0;				
				
				entrada1:
				
					state = s1;
							
				entrada2:
					
					state = s2;
				
				entrada3:
				
					state = s3;
			endcase;
									
			case (state)
				
				//**********************************//estado 0
					 s0: 
					 begin
						a_vermelho = 0;
						//corInicial_Carros_av1 <= 2'b11;
						
						c1 <= 2'b11;
						p1 <= 1'b0;
						
						c2 <= 2'b00;
						p2 <= 1'b1;
						
						//==============// PARTE CONTADORA
						
						if (verde != 5'd30) // enquanto não for 30s ele fica verde e o contador vai somando
						begin	
							verde = 5'd0 + 5'd1;
							a_verde = 0;
						end
						else
						begin
							verde = 5'd0;
							a_verde = 1;
						end
						//=============//
						if (a_verde)
							state <= s1;
						else
							state <= s0;
							
					 end	
							
					//**********************************//estado 1	
					 s1:
					 begin
						a_verde = 0;
					 //corInicial_Carros_av1 <= 2'b11;
						
						c1 <= 2'b10;
						p1 <= 1'b0;
						
						c2 <= 2'b01;
						p2 <= 1'b1;
						
						//==============// PARTE CONTADORA
						
						if (amarelo != 3'd5) // enquanto não for 30s ele fica verde e o contador vai somando
						begin	
							amarelo = 3'd0 + 3'd1;
							a_amarelo = 0;
						end
						
						else
						begin
							amarelo = 3'd0;
							a_amarelo = 1;
						end
					 
					 
						if (a_amarelo)
							state <= s2;
						else
							state <= s1;
							
					 end		
					 
					//**********************************//estado 2 
					 s2:
					 begin
						a_amarelo = 0;
					 //corInicial_Carros_av1 <= 2'b11;
						
						c1 <= 2'b00;
						p1 <= 1'b1;
						
						c2 <= 2'b11;
						p2 <= 1'b0;
						
						//==============// PARTE CONTADORA
						
						if (verde != 5'd30) // enquanto não for 30s ele fica verde e o contador vai somando
						begin	
							verde = 5'd0 + 5'd1;
							a_verde = 0;
						end
						else
						begin
							verde = 5'd0;
							a_verde = 1;
						end
					 
					 
						
						if (a_verde)
							state <= s1;
						else
							state <= s3;
					 
					 
					  end
					 //**********************************//estado 3
					 s3:
					 begin
						a_verde = 0;		 
						//corInicial_Carros_av1 <= 2'b11;
						
						c1 <= 2'b01;
						p1 <= 1'b1;
						
						c2 <= 2'b10;
						p2 <= 1'b0;
						
						//==============// PARTE CONTADORA
						
						if (vermelho != 4'd15) // enquanto não for 30s ele fica verde e o contador vai somando
						begin	
							vermelho = 4'd0 + 4'd1;
							a_vermelho = 0;
						end
						else
						begin
							vermelho = 4'd0;
							a_vermelho = 1;
						end
						
						
						
						
						if (a_vermelho)
							state <= s0;
						else
							state <= s3;
					 end		
				endcase
	end
			

end


// decodificação das saídas - combinacional
always @ (state)
begin

	case (state)
	
	s0: out = 2'b11; 
	s1: out = 2'b10;//a_amarelo;
	s2: out = 2'b11;//a_verde;
	s3: out = 2'b01;//a_vermelho;
	
	
	endcase

end
endmodule 