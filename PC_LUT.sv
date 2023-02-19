//edited
//lookup table, enter the line number you want to go

module PC_LUT #(parameter D=12)(
  input       [5:0] addr,	   // target 4 values
  output logic[D-1:0] target);

  always_comb case(addr)
    0: target = 
	1: target = 
	2: target = 
    3: target = 
    4: target = 
	5: target = 
	6: target = 
    7: target = 
    8: target = 
	9: target = 
	10: target = 
    11: target = 
    12: target = 
	13: target = 
	14: target = 
    15: target =   
    
	default: target = 12'b0;  // hold PC  
  endcase

endmodule