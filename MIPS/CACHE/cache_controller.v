module cache_controller(CLK, RESET, HitWrite, Access_MM);
    input CLK, RESET;
    input HitWrite;
    
    output reg Access_MM;

    always@(HitWrite or RESET)
    begin
	if (RESET) begin
		Access_MM <= 1'b0;
	end
	else begin 
        	if(HitWrite == 0) begin
            		Access_MM <= 1'b1;
        	end
        	else begin
            		Access_MM <= 1'b0;
        	end
	end
    end
endmodule
