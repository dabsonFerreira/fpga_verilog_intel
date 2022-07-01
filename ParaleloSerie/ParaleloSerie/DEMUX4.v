module DEMUX4 (
              input I,
				  input S0, S1,
				  output reg [3:0] O 
              );

				  
always @ (*)
begin
	case ({S1,S0})
	2'b00 : O = {3'b000,I};
	2'b01 : O = {2'b00,I,1'b0};
	2'b10 : O = {1'b0,I,2'b00};
	2'b11 : O = {I, 3'b000};
	endcase 
end				  
				  
				  
endmodule 