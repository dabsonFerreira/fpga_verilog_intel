// Quartus Prime Verilog Template
// Single Port ROM


//memoria rom que armazena arquivo txt 
//com circuito que retorna paridade dos numeros (00 ou 11)

//xnor
// A   B     O
// 0   0     1
// 0   1     0 
// 1   0     0 
// 1   1     1
module rom_paridade
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] a,
	output paridade // saida verificando a paridade  
);

	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];
	//wire par;
	

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file single_port_rom_init.txt.  Without this file,
	// this design will not compile.

	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file, or see the "Using $readmemb and $readmemh"
	// template later in this section.

	initial
	begin
		$readmemb("sinais.txt", rom);//inicializando a rom com arquivo de leitura 
	end

	always @ (posedge clk)
	begin
		a <= rom[addr];
	end

assign paridade = ^~a;// implementa a xnor

	
endmodule
