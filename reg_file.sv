//edited

// cache memory/register file
// default address pointer width = 4, for 16 registers
module reg_file #(parameter pw=2)(
  input[7:0] dat_in,
  input      clk,
  input 	 reset,
  input      wr_en,           // write enable
  input[pw:0] wr_addr,		  // write address pointer
              rd_addrA,		  // read address pointers
			  rd_addrB,
  output logic[7:0] datA_out, // read data
                    datB_out);

  logic[7:0] registers[7:0];    // 8 8-bit register

// writes are sequential (clocked)
  always_ff @(posedge clk) begin
    if(reset) begin
      registers[0] <= 8b'0;
      registers[1] <= 8b'0;
      registers[2] <= 8b'0;
      registers[3] <= 8b'0;
      registers[4] <= 8b'0;
      registers[5] <= 8b'0;
      registers[6] <= 8b'0;
      registers[7] <= 8b'0;
    end
 	else begin
      if(wr_en)			   // anything but stores or no ops
      		registers[wr_addr] <= dat_in;
    end
  end
	
  // reads are combinational
  assign datA_out = resigters[rd_addrA];
  assign datB_out = registers[rd_addrB];
  
endmodule
