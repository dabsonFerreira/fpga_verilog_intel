module cnt4 (
				input clk, EN, clr_n,
				output reg [1:0] Q,
				output TC
				);

always @ (posedge clk or negedge clr_n)
begin
	if(~clr_n)
		Q <= 2'd0;
	else
		if(EN)
			Q <= Q + 2'd1;
		
end

assign TC = (Q == 2'd3) ? 1'b1 : 1'b0;
				
endmodule 