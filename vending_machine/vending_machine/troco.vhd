package pkg_array is 
type my_array is array (0 to 2) of integer;
end package pkg_array;	


library ieee;
library work;
use work.pkg_array.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity troco is 

	port(
		-- ENTRADAS
		Clk                                             : in std_logic;
        Reset 			  	                            : in std_logic;
		moeda5cent, moeda10cent, moeda25cent 			: in boolean;
		preco									 		: in integer;
		-- SAIDAS (product check)
		produto_ok									    : out std_logic := '0';
		troco_ok							            : out my_array := (0,0,0));

end troco; 


architecture arq of troco is 
	
    -- Variáveis/sinais para mudancas de estado
	type estado is (e0, e5, e10, e15, e20, e25, e30, e35, e40, e45, e50, eTroco);
	signal e_atual   : estado;
	signal e_proximo : estado;
	-- Variáveis/sinais p/ monitorar troco
	
	constant moedas : my_array   := (25,10,5); -- moedas que a máquina contém
	signal qnt_moedas_inicial : my_array := (10,10,10); -- qnt de moedas que a máquina vai iniciar o ciclo.
	signal valor_depositado : integer := 0; -- sinal que vai sendo atualizado dependendo da moeda que for depostidada

	begin

		--- Processo para resetar o controlador
		process (Clk, Reset)
		begin	
			if(Reset = '1') then
				e_atual <= e0;			
			elsif (rising_edge(Clk)) then
				e_atual <= e_proximo;
			end if;	
		end process;

		--- processo para mudança de estados		
		process (preco, e_atual, moeda5cent, moeda10cent, moeda25cent)
		
		
		variable qnt_moedas_contas : my_array := (0,0,0);
		variable troco_necessario: integer := 0;
		variable troco_restante  : integer := 0;
		variable qnt_troco : my_array := (0,0,0);
		variable troco_possivel : integer := 0;

		begin 		
			case e_atual is 			
			-- ESTADO 0 (IDLE)
				when e0 =>	
                produto_ok <= '0';
                valor_depositado <= 0;
                troco_ok <= (0,0,0);
				troco_necessario := 0;
				troco_restante := 0;
				qnt_troco := (0,0,0);
				troco_possivel := 0;

				if(valor_depositado >= preco) then
					e_proximo <= eTroco;
				else 
					 
					if   (moeda5cent) then  e_proximo <= e5;  valor_depositado <= valor_depositado + 5;  qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;						
					elsif(moeda10cent)then  e_proximo <= e10; valor_depositado <= valor_depositado + 10;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;		
					elsif(moeda25cent)then  e_proximo <= e25; valor_depositado <= valor_depositado + 25;  qnt_moedas_inicial(0)  <=  qnt_moedas_inicial(0) + 1;		  				
					else e_proximo <= e0; -- se nada acontecer, permanece no mesmo estado
					end if;
				end if;	
				-- ESTADO 5 CENTAVOS	
				when e5 =>
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';	
						if   (moeda5cent)  	then e_proximo <= e10;  valor_depositado <= valor_depositado + 5;   qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;
						elsif(moeda10cent) 	then e_proximo <= e15;  valor_depositado <= valor_depositado + 10;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;
						elsif(moeda25cent) 	then e_proximo <= e30;  valor_depositado <= valor_depositado + 25;  qnt_moedas_inicial(0)  <=  qnt_moedas_inicial(0) + 1;
						else e_proximo <= e5;
						end if;
					end if;							
					
				-- ESTADO 10 CENTAVOS	
				when e10 =>
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';	
					
						if   (moeda5cent)  	then e_proximo <= e15;  qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;  valor_depositado <= valor_depositado + 5; 
						elsif(moeda10cent) 	then e_proximo <= e20;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;valor_depositado <= valor_depositado + 10;
						elsif(moeda25cent) 	then e_proximo <= e35;  qnt_moedas_inicial(0)  <=  qnt_moedas_inicial(0) + 1;valor_depositado <= valor_depositado + 25;
						else e_proximo <= e10;
						end if;
					end if;					

				-- ESTADO 15 CENTAVOS	
				when e15 =>
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';	
						if   (moeda5cent)  	then e_proximo <= e20;  qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;  valor_depositado <= valor_depositado + 5; 
						elsif(moeda10cent) 	then e_proximo <= e25;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;valor_depositado <= valor_depositado + 10;
						elsif(moeda25cent) 	then e_proximo <= e40;  qnt_moedas_inicial(0)  <=  qnt_moedas_inicial(0) + 1;valor_depositado <= valor_depositado + 25;
						else e_proximo <= e15;
						end if;	
					end if;	
		
				-- ESTADO 20 CENTAVOS	
				when e20 =>
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';
						if   (moeda5cent)  	then e_proximo <= e25;  qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;  valor_depositado <= valor_depositado + 5; 
						elsif(moeda10cent) 	then e_proximo <= e30;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;valor_depositado <= valor_depositado + 10;
						elsif(moeda25cent) 	then e_proximo <= e45;  qnt_moedas_inicial(0)  <=  qnt_moedas_inicial(0) + 1;valor_depositado <= valor_depositado + 25;
						else e_proximo <= e20;
						end if;	
					end if;
					
				-- ESTADO 25 CENTAVOS	
				when e25 =>	
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';
						if   (moeda5cent)  	then e_proximo <= e30;  qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;  valor_depositado <= valor_depositado + 5; 
						elsif(moeda10cent) 	then e_proximo <= e35;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;valor_depositado <= valor_depositado + 10;					
						elsif(moeda25cent) 	then e_proximo <= e50;  qnt_moedas_inicial(0)  <=  qnt_moedas_inicial(0) + 1;valor_depositado <= valor_depositado + 25;
						else e_proximo <= e25;
						end if;
					end if;
					
				-- ESTADO 30 CENTAVOS	
				when e30 =>
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';
						if   (moeda5cent)  	then e_proximo <= e35;  qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;  valor_depositado <= valor_depositado + 5; 
						elsif(moeda10cent) 	then e_proximo <= e40;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;valor_depositado <= valor_depositado + 10;					
						elsif(moeda25cent) 	then e_proximo <= e30; 
						else e_proximo <= e30;
						end if;
					end if;
					
				-- ESTADO 35 CENTAVOS	
				when e35 =>
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';
						if   (moeda5cent)  	then e_proximo <= e40;  qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;  valor_depositado <= valor_depositado + 5; 
						elsif(moeda10cent) 	then e_proximo <= e45;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;valor_depositado <= valor_depositado + 10;					
						elsif(moeda25cent) 	then e_proximo <= e35;
						else e_proximo <= e35;
						end if;
					end if;
					
				-- ESTADO 40 CENTAVOS	
				when e40 =>
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';
						if   (moeda5cent)  	then e_proximo <= e45;  qnt_moedas_inicial(2)  <=  qnt_moedas_inicial(2) + 1;  valor_depositado <= valor_depositado + 5; 
						elsif(moeda10cent) 	then e_proximo <= e50;  qnt_moedas_inicial(1)  <=  qnt_moedas_inicial(1) + 1;valor_depositado <= valor_depositado + 10;					
						elsif(moeda25cent) 	then e_proximo <= e40;
						else e_proximo <= e40;
						end if;
					end if;

				-- ESTADO 45 CENTAVOS	
				when e45 =>
				
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';
						if   (moeda5cent)  	then e_proximo <= e50;  
						elsif(moeda10cent) 	then e_proximo <= e45;				
						elsif(moeda25cent) 	then e_proximo <= e45;
						else e_proximo <= e45;
						end if;
					end if;

				-- ESTADO 50 CENTAVOS	
				when e50 =>
					if(valor_depositado >= preco) then
						e_proximo <= eTroco;
					else 
						produto_ok <= '0';
						if   (moeda5cent)  	then e_proximo <= e50; 
						elsif(moeda10cent) 	then e_proximo <= e50; 					
						elsif(moeda25cent) 	then e_proximo <= e50; 
						else e_proximo <= e50;
						end if;
					end if;
				
				when eTroco =>
						qnt_moedas_contas(0) := qnt_moedas_inicial(0);
						qnt_moedas_contas(1) := qnt_moedas_inicial(1);
						qnt_moedas_contas(2) := qnt_moedas_inicial(2);

						troco_necessario := valor_depositado - preco;
						troco_restante := troco_necessario;
						qnt_troco :=(0,0,0);
						troco_possivel := 0;
						for i in 0 to 2 loop
							for ii in 0 to 10 loop -- só pode dar 11 moedas do mesmo valor de troco
								if((troco_restante >= moedas(i)) and (qnt_moedas_contas(i) > 0) ) then 
									troco_possivel := troco_possivel + moedas(i);
									troco_restante := troco_restante - moedas(i);
									qnt_moedas_contas(i) := qnt_moedas_contas(i) - 1;
									qnt_troco(i) := qnt_troco(i) + 1;
								else
									exit;
								end if;		
							end loop;
						end loop;
						
						if (troco_possivel = troco_necessario) then
							e_proximo <= e0;
							produto_ok <= '1';
							qnt_moedas_inicial <= (qnt_moedas_contas(0), qnt_moedas_contas(1), qnt_moedas_contas(2));
							troco_ok <= (qnt_troco(0),qnt_troco(1),qnt_troco(2));
							valor_depositado <= 0;	
						else
							qnt_moedas_contas := (qnt_moedas_inicial(0), qnt_moedas_inicial(1), qnt_moedas_inicial(2)) ;

							troco_necessario := valor_depositado;
							troco_restante := troco_necessario;
							qnt_troco :=(0,0,0);
							troco_possivel := 0;
							for i in 0 to 2 loop
								for ii in 0 to 10 loop -- só pode dar 10 moedas do mesmo valor de troco
									if((troco_restante >= moedas(i)) and (qnt_moedas_contas(i) > 0) ) then 
										troco_possivel := troco_possivel + moedas(i);
										troco_restante := troco_restante - moedas(i);
										qnt_moedas_contas(i) := qnt_moedas_contas(i) - 1;
										qnt_troco(i) := qnt_troco(i) + 1;
									else
										exit;
									end if;		
								end loop;
							end loop;
							e_proximo <= e0;
							produto_ok <= '0';
							qnt_moedas_inicial <= (qnt_moedas_contas(0), qnt_moedas_contas(1), qnt_moedas_contas(2));							
							troco_ok <= (qnt_troco(0),qnt_troco(1),qnt_troco(2));
							valor_depositado <= 0;		

						end if;		
			end case;
				
		end process;	
end architecture;