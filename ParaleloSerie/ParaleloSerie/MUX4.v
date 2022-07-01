module MUX4 (
            input I0, I1, I2, I3,
				input S0, S1,
				output reg Z
            );
				
always @ (*)
begin
	case ({S1,S0})
	2'b00 : Z = I0;
	2'b01 : Z = I1;
	2'b10 : Z = I2;
	2'b11 : Z = I3;
	endcase
end

endmodule 