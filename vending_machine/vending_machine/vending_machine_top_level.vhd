package pkg_array is 
type my_array is array (0 to 2) of integer;
end package pkg_array;	


library ieee;
library work;
use work.pkg_array.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.rom_precos;
use work.state_machine;


entity vending_machine_top_level is 

	port(
		-- ENTRADAS
		Clk                                     : in std_logic;
        Reset 			  	                    : in std_logic;
		moeda5cent, moeda10cent, moeda25cent    : in boolean;
		produto		                            : in std_logic_vector(1 downto 0);
		-- SAIDAS (product check)
		produto_ok							    : out std_logic := '0';
		troco_ok							    : out my_array := (0,0,0));

end vending_machine_top_level;

architecture arc of vending_machine_top_level is 
signal preco_wire : integer := 0;
begin
    E_ROM: entity work.rom_precos(rom_arq)
    port map (produto => produto,
              preco => preco_wire);
    
    
    E_statemachine: entity work.troco(arq)
    port map (Clk         => Clk,
              Reset       => Reset,
              moeda5cent  => moeda5cent,
              moeda10cent => moeda10cent,
              moeda25cent => moeda25cent,
              preco       => preco_wire,
              produto_ok  => produto_ok,
              troco_ok    => troco_ok);


end architecture;