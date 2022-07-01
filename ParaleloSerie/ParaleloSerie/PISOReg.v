module PISOReg (
               input clk, clr_n, load, sh_ena,
					input [3:0] data_in,
					output data_out
               );

reg [3:0] PISO_Reg;

always @ (posedge clk or negedge clr_n)
begin
	if(~clr_n)
		PISO_Reg <= 4'b0000;
	else
		if(load)
			PISO_Reg <= data_in;
		else
			if(sh_ena)
			begin
				PISO_Reg[0] <= PISO_Reg[1];
				PISO_Reg[1] <= PISO_Reg[2];
				PISO_Reg[2] <= PISO_Reg[3];
				PISO_Reg[3] <= PISO_Reg[0];
			end
end

assign data_out = PISO_Reg[0];

endmodule 