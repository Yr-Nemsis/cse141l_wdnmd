//edited
//lookup table, enter the line number you want to go

module PC_LUT #(parameter D=12)(
  input       [5:0] addr,	   // target 4 values
  output logic[D-1:0] target);

  always_comb case(addr)
    0: target = 11;
	1: target = 15;
	2: target = -17;
    3: target = 4;
    4: target = -28;
	5: target = -38;
	6: target = 6;
    7: target = -30;
    8: target = -18;
	9: target = -26;
	10: target = -29;
    11: target = -39;
    12: target = -41;
	13: target = -54;
	14: target = 12'b0;
    15: target = 12'b0;
    //program 1
    16: target = 14;  //beq end
    17: target = -142; //beq loop
    //program 2
    18: target = 2;   //beq skip1 on line 87
    19: target = 21;  //beq skip2 on line 100
    20: target = 7;   //beq small on line 112
    21: target = 3;   //beq skip2 on line 118
    22: target = 14;  //beq end on line 144
    23: target = -137; //beq loop on line 157
	default: target = 12'b0;  // hold PC  
  endcase

endmodule