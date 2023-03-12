//edited
//lookup table, enter the line number you want to go

module PC_LUT #(parameter D=12)(
  input       [5:0] addr,	   // target 4 values
  output logic[D-1:0] target);

  always_comb case(addr)
    // program 3
    0: target = 11;
    1: target = 15;
    2: target = -17;
    3: target = 4;
    4: target = -28;
    5: target = -39;
    6: target = 6;
    7: target = -30;
    8: target = -18;
    9: target = -26;
    10: target = -29;
    11: target = -39;
    12: target = -41;
    13: target = -62;
    14: target = 12'b0;
    15: target = 12'b0;
    //program 1
    16: target = 14;  //beq end
    17: target = -143; //beq loop
    //program 2
    18: target = -174;   //beq loop on line 194
    19: target = 14;  //beq end on line 181
    20: target = 9;   //beq small on line 104
    21: target = 14;   //beq hello on line 112
    22: target = 7;  //beq hello on line 119
    23: target = 3; //beq hello on line 123
    26: target = 37; //beq skip1 on line 87
    27: target = 28; //beq skip2 on line 92	 
    //program 3
    24: target = -37;
    25: target = -48;
	default: target = 12'b0;  // hold PC  
  endcase

endmodule
