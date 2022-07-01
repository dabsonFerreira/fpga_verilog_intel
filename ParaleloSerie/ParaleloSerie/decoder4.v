module decoder4 (
                input A, B,
					 input EN,
					 output reg [3:0] O
                );

					 
always @ (*)
begin
	if(EN)
	begin
		case ({B,A})
		2'b00 : O = 4'b0001;
		2'b01 : O = 4'b0010;
		2'b10 : O = 4'b0100;
		2'b11 : O = 4'b1000;
		endcase 
	end
	else
		O = 4'b0000;

end

endmodule 