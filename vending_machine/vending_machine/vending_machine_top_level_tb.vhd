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
use work.vending_machine_top_level;


entity vending_machine_top_level_tb is 
end entity;

architecture sim of vending_machine_top_level_tb is 

	constant ClockPeriod      : time                         := 1 ns; 	
	signal   clk              : std_logic                    := '1'; -- starting the clock high.
	signal 	rst              : std_logic                    := '0';
	signal   tb_moeda5cent    : boolean                      := false;
	signal   tb_moeda10cent   : boolean                      := false;
	signal   tb_moeda25cent   : boolean                      := false;
	signal 	tb_produto		  : std_logic_vector(1 downto 0) := "00";
	signal   tb_produto_ok    : std_logic                    := '0';
   signal   tb_troco_ok      : my_array                     := (0,0,0);
	

begin
	vending_machine_top_level : entity work.vending_machine_top_level(arc)
	port map (
		Clk 		  => clk,
		Reset         => rst,
		moeda5cent    => tb_moeda5cent,
		moeda10cent   => tb_moeda10cent,
		moeda25cent   => tb_moeda25cent,
		produto   	  => tb_produto,
		produto_ok    => tb_produto_ok,
        	troco_ok      => tb_troco_ok);

		
	-- Process for generating the clock
	clk <= not clk after ClockPeriod/2;	
	
	process is
	begin
		
		
		tb_produto <= "10";
		wait for 1 ns;
		-- primeira moeda: de 25
        tb_moeda5cent  <= false;
        tb_moeda10cent <= false;
		tb_moeda25cent   <= true;
		wait for 1 ns;
        tb_moeda5cent  <= false;
        tb_moeda10cent <= false;
		tb_moeda25cent   <= false;
		wait for 1 ns;

		-- segunda moeda: de 25
      tb_moeda5cent  <= false;
      tb_moeda10cent <= false;
		tb_moeda25cent <= true;
		wait for 1 ns;
        tb_moeda5cent  <= false;
        tb_moeda10cent <= false;
		  tb_moeda25cent <= false;
		wait for 1 ns;
		-- terceira moeda: de 25
        tb_moeda5cent  <= false;
        tb_moeda10cent <= true;
		tb_moeda25cent <= false;
		wait for 1 ns;
        tb_moeda5cent  <= false;
        tb_moeda10cent <= false;
		tb_moeda25cent <= false;
		wait for 1 ns;		
		
		-- terceira moeda: de 25

		

		wait;
		
		
		
	end process;
	
end architecture;		
