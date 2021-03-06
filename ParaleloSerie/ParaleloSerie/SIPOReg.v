module SIPOReg (
               input clk, clr_n, ena,
				   input data_in,
				   output [3:0] data_out	 
					);
					
reg [3:0] SIPO_Reg;

always @ (posedge clk or negedge clr_n)
begin
	if(~clr_n)
		SIPO_Reg <= 4'b0000;
	else
		if(ena)
		begin
			SIPO_Reg[0] <= SIPO_Reg[1];
			SIPO_Reg[1] <= SIPO_Reg[2];
			SIPO_Reg[2] <= SIPO_Reg[3];
			SIPO_Reg[3] <= data_in;
		end
end

assign data_out = SIPO_Reg;

endmodule 