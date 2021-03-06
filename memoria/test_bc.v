
`timescale 1ns/100ps


module test_bc();
	parameter tamanho_endereco = 8;
	reg [tamanho_endereco-1:0] t_end;
	


	parameter tamanho_sinal = 8;
	wire [tamanho_sinal-1:0] sinal_o;

	
	wire paridade_analise;
	
	
	reg clk;
	

		initial
				fork
					clk = 1'd0;
					t_end = 8'd0;

				forever
					#40 clk = ~clk;	
		join

		
		
		always @ (posedge clk)
		
		
				begin
				
					t_end <= t_end + 8'd1;
			
				end

rom_paridade
#(.DATA_WIDTH(tamanho_sinal), 
  .ADDR_WIDTH(tamanho_endereco)
  )
  DUT
  (
   
	
	.addr(t_end),
	
	.clk(clk), 
	
	.a(sinal_o),
	
	.paridade(paridade_analise)
	
  );

endmodule 