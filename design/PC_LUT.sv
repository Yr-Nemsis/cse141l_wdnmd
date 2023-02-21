//edited
//lookup table, enter the line number you want to go

module PC_LUT #(parameter D=12)(
  input       [5:0] addr,	   // target 4 values
  output logic[D-1:0] target);

  always_comb case(addr)
    0: target = 6;
	1: target = -9;
	2: target = 12'b0;
    3: target = 12'b0;
    4: target = 12'b0;
	5: target = 12'b0;
	6: target = 12'b0;
    7: target = 12'b0;
    8: target = 12'b0;
	9: target = 12'b0;
	10: target = 12'b0;
    11: target = 12'b0;
    12: target = 12'b0;
	13: target = 12'b0;
	14: target = 12'b0;
    15: target = 12'b0;
    
	default: target = 12'b0;  // hold PC  
  endcase

endmodule