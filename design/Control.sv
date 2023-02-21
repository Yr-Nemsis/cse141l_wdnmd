//edited

// control decoder
module Control #(parameter opwidth = 3, mcodebits = 3)(
  input [mcodebits-1:0] instr,    // subset of machine code (any width you need)
  output logic Branch, 
     MemtoReg, MemWrite, ALUSrc, RegWrite,
     Move, MemRead, 
  output logic[opwidth-1:0] ALUOp);	   // for up to 8 ALU operations

always_comb begin
// defaults
  Branch    =   'b0;
  MemtoReg  =   'b0; //0: alu to regfile
  MemWrite  =   'b0;
  ALUSrc    =   'b0;
  RegWrite  =   'b1;
  Move      =   'b0;
  MemRead   =   'b0;
  //Sign_extend = 'b0;  //0: zero_extend
  ALUOp     =   'b000;
// sample values only -- use what you need
	case(instr)
	  'b000: begin    //add
        Branch    =   'b0;
  		MemtoReg  =   'b0;
  		MemWrite  =   'b0;
  		ALUSrc    =   'b0;
  		RegWrite  =   'b1;
  		Move      =   'b0;
  		MemRead   =   'b0;
  		//Sign_extend = 'b0;  //0: zero_extend
  		ALUOp     =   'b000;
      end
      
      'b001: begin    //and
        Branch    =   'b0;
  		MemtoReg  =   'b0;
  		MemWrite  =   'b0;
  		ALUSrc    =   'b0;
  		RegWrite  =   'b1;
  		Move      =   'b0;
  		MemRead   =   'b0;
  		//Sign_extend = 'b0;  //0: zero_extend
  		ALUOp     =   'b001;
      end
      
      'b101: begin    //load
        Branch    =   'b0;
  		MemtoReg  =   'b1;
  		MemWrite  =   'b0;
  		ALUSrc    =   'b0;
  		RegWrite  =   'b1;
  		Move      =   'b0;
  		MemRead   =   'b1;
  		//Sign_extend = 'b0;  //0: zero_extend
  		ALUOp     =   'b101;
      end
      
      'b110: begin    //store
        Branch    =   'b0;
  		MemtoReg  =   'b0; //does not matter
  		MemWrite  =   'b1;
  		ALUSrc    =   'b0;
  		RegWrite  =   'b0;
  		Move      =   'b0;
  		MemRead   =   'b1;
  		//Sign_extend = 'b0;  //0: zero_extend
  		ALUOp     =   'b110;
      end
      
      'b100: begin    //move
        Branch    =   'b0;
  		MemtoReg  =   'b0;
  		MemWrite  =   'b0; 
  		ALUSrc    =   'b1; //immediate
  		RegWrite  =   'b1; 
  		Move      =   'b1; 
  		MemRead   =   'b0;
  		//Sign_extend = 'b0;  //0: zero_extend
  		ALUOp     =   'b100;
      end
      
      'b111: begin    //rtl
        Branch    =   'b0;
  		MemtoReg  =   'b0;
  		MemWrite  =   'b0;
  		ALUSrc    =   'b0;
  		RegWrite  =   'b1;
  		Move      =   'b0;
  		MemRead   =   'b0;
  		//Sign_extend = 'b0;  //does not matter
  		ALUOp     =   'b111;
      end
      
      'b010: begin    //xor
        Branch    =   'b0;
  		MemtoReg  =   'b0;
  		MemWrite  =   'b0;
  		ALUSrc    =   'b0;
  		RegWrite  =   'b1;
  		Move      =   'b0;
  		MemRead   =   'b0;
  		//Sign_extend = 'b0;  //does not matter
  		ALUOp     =   'b010;
      end
      
      'b011: begin    //beq
        Branch    =   'b1;
  		MemtoReg  =   'b0; //does not matter
  		MemWrite  =   'b0; 
  		ALUSrc    =   'b0; 
  		RegWrite  =   'b0; 
  		Move      =   'b0;
  		MemRead   =   'b0;
  		//Sign_extend = 'b0; 
  		ALUOp     =   'b011;
      end
	endcase

end
	
endmodule