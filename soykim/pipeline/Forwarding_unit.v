//no use EXMEM_MemWrite_out

module Forwarding_unit (rst, EXMEM_RegWrite_out, MEMWB_RegWrite_out, EXMEM_MemWrite_out, IDEX_RegWrite_out,IDEX_MemWrite_out,
IDEX_rs_out, IDEX_rt_out, EXMEM_destination_out, MEMWB_destination_out,forwarding_output1, forwarding_output2//,equal1, equal2, equal3, equal4
);
	input rst, EXMEM_RegWrite_out, MEMWB_RegWrite_out, EXMEM_MemWrite_out, IDEX_RegWrite_out,IDEX_MemWrite_out;
	input [4:0] IDEX_rs_out, IDEX_rt_out, EXMEM_destination_out, MEMWB_destination_out; 
	output [1:0] forwarding_output1, forwarding_output2;
	
	//   assign equal1 = (EXMEM_destination_out == IDEX_rs_out) ? 1'b1 : 1'b0;
	//   assign equal2 = (EXMEM_destination_out == IDEX_rt_out) ? 1'b1 : 1'b0;
	//   assign equal3 = (MEMWB_destination_out == IDEX_rs_out) ? 1'b1 : 1'b0;
	//   assign equal4 = (MEMWB_destination_out == IDEX_rt_out) ? 1'b1 : 1'b0;
	
	assign forwarding_output1 = (rst == 1'b0) ? 2'b00 : (
		(EXMEM_RegWrite_out == 1'b1 && (EXMEM_destination_out == IDEX_rs_out)) ? 2'b10 : (
		(MEMWB_RegWrite_out == 1'b1 && (MEMWB_destination_out == IDEX_rs_out)) ? 2'b01 : 2'b00 ) );
	assign forwarding_output2 = (rst == 1'b0) ? 2'b00 : (
		(EXMEM_RegWrite_out == 1'b1 && (EXMEM_destination_out == IDEX_rt_out)) ? (
			(IDEX_RegWrite_out == 1'b0 && IDEX_MemWrite_out == 1'b1) ? 2'b11 : 2'b10 ) : (
		(MEMWB_RegWrite_out == 1'b1 && (MEMWB_destination_out == IDEX_rt_out)) ? 2'b01 : 2'b00 ) );
		
	
	
	/*
always@ (rst, EXMEM_RegWrite_out, equal1, equal2, equal3, equal4, IDEX_RegWrite_out, IDEX_MemWrite_out)
begin

   if(rst==1'b0) begin
      forwarding_output1 <= 2'b00;
      forwarding_output2 <= 2'b00;
   end
   else begin
      
      if((EXMEM_RegWrite_out & equal1) == 1) begin
	 forwarding_output1 <= 2'b10;
      end
      else if ((MEMWB_RegWrite_out & equal3) == 1) begin
         forwarding_output1 <= 2'b01;
      end
      else begin
         forwarding_output1 <= 2'b00;
      end
         
      if((EXMEM_RegWrite_out & equal2) == 1) begin
	 if((!IDEX_RegWrite_out & IDEX_MemWrite_out) == 1'b1) begin
		forwarding_output2 <= 2'b11;
	 end
	 else begin
		forwarding_output2 <= 2'b10;
	 end 
      end
      else if ((MEMWB_RegWrite_out & equal4) == 1) begin
         forwarding_output2 <= 2'b01;
      end
      else begin
         forwarding_output2 <= 2'b00;      
      end


   end 
end*/
endmodule