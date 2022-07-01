`timescale 1ns/100ps

module TOP_tb();


reg  [3:0] ina, inb, inc,ind;
wire [3:0] out;
reg        clk, transmit, ia, ib, ic, id, clr_n;
wire [1:0] bit, word;
wire       mux, sent, recieved;


initial
	begin

		clk = 1'b0;	
			
		forever 
			begin			
				#20 clk = ~clk;
				
			end	
	end
	
//********clear******	
initial 
begin	

	clr_n = 1'b0;	
	#50 clr_n = 1'b1;	
	
end	


initial
begin
				//sinal de entrada
				ina = 4'b0101;
				inb = 4'b1100;
				inc = 4'b0000;
				ind = 4'b1111;//carrega os piso no clock 0
				
				
				transmit    = 1'b0;	//transmissão nula para carregar regs	
				
				//load
				ia = 1'd0; //circuito começa carregado
				ib = 1'd0 ;
				ic = 1'd0 ;
				id = 1'd0 ;
		
		#100  ia = 1'd1 ; 
		#120 	ia = 1'd0 ;//circuito começa carregado
				
		#120	ib = 1'd1 ;
		#140	ib = 1'd0 ;		
				
		#140	ic = 1'd1 ;
		#160	ic = 1'd0 ;
				
		#160	id = 1'd1 ;
		#180	id = 1'd0 ;
	
		#200  transmit    = 1'b1;
		#230  transmit    = 1'b0;
		
		
		//#10   transmit    = 1'b1;
		
		//clock e clr_n
		      clr_n       = 1'b1;	//todos os regs zerados			
		      clk         = 1'b0;
		#80	clr_n       = 1'b1;
		#800  clr_n       = 1'b0;
		
		
		
		

end




TOP serialtransmissor( 
							 .clk(clk), .clr_n(clr_n), //clr eh para saber inicio do piso.
							 
			             .ldA(ia), .ldB(ib), .ldC(ic), .ldD(id),//bit logico que habilita carga paralela
							 
			             .inA(ina), .inB(inb), .inC(inc), .inD(ind),//sinal de entrada reg							 
							 
			             .transmit(transmit),// sinal que inicializa transmissão - liga os cont
			             .data(mux),//saída do multi
							 
			             .QbitRX(bit), .QwrdRX(word), //contagem de bit e de palavra 
							 
			             .sent_n(sent), .received_n(recieved),//sinais ativos em 0 
							 
			             .outA(out[0]), .outB(out[1]), .outC(out[2]), .outD(out[3])//registradores de saída					
							);						
										


endmodule