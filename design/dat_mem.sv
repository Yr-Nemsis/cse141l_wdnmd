//edited

// 8-bit wide, 256-word (byte) deep memory array
module dat_mem (
  input[7:0] dat_in,
  input      clk,
  input      rd_en,
  input      wr_en,	          // write enable
  input		 reset,
  input[7:0] addr,		      // address pointer
  output logic[7:0] dat_out);

  logic[7:0] data_mem[256];       // 2-dim array  8 wide  256 deep
  
// reads are combinational; no enable or clock required
  assign dat_out = (rd_en == 1'b1) ? data_mem[addr] : 8'd0;
  
// writes are sequential (clocked) -- occur on stores or pushes 
  always_ff @(posedge clk) begin
    if(wr_en) begin				  // wr_en usually = 0; = 1 		
      data_mem[addr] <= dat_in; 
    end
  	if(reset) begin
      for(int i = 61; i < 256; i++) begin
      		data_mem[i] <= 8'd0;
      end
    end
  end

endmodule