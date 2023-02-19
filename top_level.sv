// sample top level design
module top_level(
  input        clk, reset, req, 
  output logic done);
  parameter D = 12,             // program counter width
    A = 3;             		  // ALU command bit width
  wire[D-1:0] target, 			  // jump 
              prog_ctr;
  wire        RegWrite;
  wire[7:0]   datA,datB, 		//from RegFile
              muxB, 			
			  rslt,               // alu output
  			  regfile_dat;
  			  dat_mem_out;

  logic sc_in,   				  // shift/carry out from/to ALU
   		pariQ,              	  // registered parity flag from ALU
		zeroQ;                    // registered zero flag from ALU 
  
  wire  relj,                    // from control to PC; relative jump enable
   		pari,
        zero,
		sc_clr,
		sc_en,
        MemWrite,
  		MemRead,
  		MemToReg,
  		Move,
  		Branch,
        ALUSrc;		              // immediate switch
  wire[A-1:0] alu_cmd;
  wire[8:0]   mach_code;          // machine code
  wire[2:0] reg_adrA, reg_adrB;   //rd_addrA, rd_adrB;
  wire[5:0] immed;
  
// fetch subassembly
  PC #(.D(D)) pc1 (.reset(reset),  // D sets program counter width
                   .clk(clk),
		 		   .reljump_en (relj),
                   .target(target),
                   .prog_ctr(prog_ctr));

// lookup table to facilitate jumps/branches
  PC_LUT #(.D(D)) pl1 (.addr(immed),
                       .target(target));   

// contains machine code
  instr_ROM ir1(.prog_ctr,
               .mach_code);

// control decoder
  Control ctl1(.instr(alu_cmd),.Branch(Branch),.MemWrite(MemWrite),
               .MemRead(MemRead),.ALUSrc(ALUSrc),.RegWrite(RegWrite),.ALUOp(alu_cmd),
               .Move(Move),.MemtoReg(MemToReg));

  assign rd_addrA = (Branch == 1'b0) ? mach_code[5:3] : 3'b111;
  assign rd_addrB = (Branch == 1'b0) ? mach_code[2:0] : 3'b110;
  assign immed = (Move == 1'b0) ? {2'b00, mach_code[5:0]}:{5'b00000, mach_code[2:0]};
  assign alu_cmd  = mach_code[8:6];

  reg_file #(.pw(2)) rf1(.dat_in(regfile_dat),	   // loads, most ops
                         .clk,.reset(reset),
              			 .wr_en(RegWrite),
              			 .rd_addrA(rd_addrA),
              			 .rd_addrB(rd_addrB),
                         .wr_addr (rd_addrA),      // in place operation
              			 .datA_out(datA),
                         .datB_out(datB)); 

  assign muxB = (ALUSrc == 1'b0) ? datB : immed;
  
  alu alu1(.alu_cmd(alu_cmd),.inA(datA),.inB(muxB),
		   .sc_i(sc),   // output from sc register
           .rslt(rslt),
		   .sc_o(sc_o), // input to sc register
           .pari(pari),
           .zeroQ(zeroQ));  

  assign relj = (Branch & zeroQ == 1) ? 1'b1 : 1'b0; 
    
  dat_mem dm1(.dat_in(datA)  ,  // from reg_file
              .clk           ,
			  .wr_en(MemWrite), // stores
              .addr(rslt),
              .dat_out(dat_mem_out));

  assign regfile_dat = (MemToReg == 1'b0) ? rslt : dat_mem_out;
  
// registered flags from ALU
  always_ff @(posedge clk) begin
    pariQ <= pari;
	zeroQ <= zero;
    if(sc_clr)
	  sc_in <= 'b0;
    else if(sc_en)
      sc_in <= sc_o;
  end

  assign done = prog_ctr == 128; //the line number of after the last instruction. 
 
endmodule