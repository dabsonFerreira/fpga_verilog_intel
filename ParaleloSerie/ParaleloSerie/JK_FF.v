module JK_FF (
				  input clk, j, k, clr_n,
				  output reg q 
				  );

always @ (posedge clk)
begin
	if(~clr_n)
		q <= 1'b0;
	else
		case ({j,k})
			2'b00 : q <= q;
			2'b01 : q <= 1'b0;
			2'b10 : q <= 1'b1;
			2'b11 : q <= ~q;
		endcase
end				  
				  
endmodule 