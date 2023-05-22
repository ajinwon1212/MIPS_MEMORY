module cache_controller(CLK, HitWrite, Access_MM);
    input CLK;
    input HitWrite;
    
    output reg Access_MM;

    always@(posedge clk)
    begin
        if(HitWrite == 1) begin
            Access_MM = 0;
        end
        else begin
            Access_MM = 1;
        end
    end
endmodule
