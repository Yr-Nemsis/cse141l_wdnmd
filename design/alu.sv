// combinational -- no clock
// sample -- change as desired
module alu(
  input[2:0] alu_cmd,    // ALU instructions
  input[7:0] rd_A, rd_B,	 // 8-bit wide data path
  input[2:0] rd_addrA,		  // read address pointers
			 rd_addrB,
  output logic[7:0] rslt,
  output logic zero      // NOR (output)
);

always_comb begin 
  rslt = 'b0;            
  zero = 'b0;
  case(alu_cmd)
    3'b000: //add rs rt (rs += rt)
      rslt = rd_A + rd_B;
    
    3'b001: //and rs rt
      rslt = 8'b0 + (rd_A & rd_B);
    
    3'b010: begin //xor rs rt
      if(rd_addrA == rd_addrB) begin
        rslt = 8'b0 + ^(rd_A);
      end
      else begin
        rslt = rd_A ^ rd_B;
      end
    end
    
    3'b011: begin //beq, lookup table
      rslt = rd_A - rd_B;
      zero = rd_A == rd_B;
    end
    
    3'b100: //move
      rslt = rd_B;
    
    3'b101: //load
      rslt = rd_B;
    
    3'b110: //store
      rslt = rd_B;
    
    3'b111: begin//rtl rs rt
      case(rd_B)
        8'b00000000:
          rslt = rd_A;
        8'b00000001:
          rslt = {rd_A[6:0], rd_A[7]};
        8'b00000010:
          rslt = {rd_A[5:0], rd_A[7:6]};
        8'b00000011:
          rslt = {rd_A[4:0], rd_A[7:5]};
        8'b00000100:
          rslt = {rd_A[3:0], rd_A[7:4]};
        8'b00000101:
          rslt = {rd_A[2:0], rd_A[7:3]};
        8'b00000110:
          rslt = {rd_A[1:0], rd_A[7:2]};
        8'b00000111:
          rslt = {rd_A[0], rd_A[7:1]};
      endcase
    end
  endcase
end
   
endmodule