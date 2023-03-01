// testbench for program counter and alu
module milestone2_tb();

logic clk    = 'b0,                 // clock source -- drives DUT input of same name
	  init   = 'b0,	                // init -- start the DUT -- drives DUT input
  	  reset  = 'b0;
wire done;
logic error[4];
 
top_level dut(.*);
  
always begin
  #5ns clk = 1;            
  #5ns clk = 0;			   
end	
  
initial begin
  $dumpfile("dump.vcd"); 
  $dumpvars;
  dut.dm1.data_mem[0] = 'b11110000;
  dut.dm1.data_mem[1] = 'b11001100;
//   dut.dm1.data_mem[3] = 'b11110000;
  dut.dm1.data_mem[4] = 'b11000011;
  #10ns reset = 1;
  #10ns reset = 0;
  #10ns wait(done);
  // Testing Move, Load, Xor, Add, Store
  #10ns error[0] = (8'b11110000 ^ 8'b11001100) != dut.dm1.data_mem[2]; 
  // Testing And, Rtl
  #10ns error[1] = (8'b11000011 & 8'b11000011) != dut.dm1.data_mem[5];
  // Testing Reduction Xor 
  #10ns error[2] = ^(8'b11110000) != dut.dm1.data_mem[6];
  // Testing Beq
  #10ns error[3] = (8'b00000111) != dut.dm1.data_mem[7];
  // Displaying the error detected
  #10ns $display("error[0]: %d\n",error[0]);
  #10ns $display("error[1]: %d\n",error[1]);
  #10ns $display("error[2]: %d\n",error[2]);
  #10ns $display("error[3]: %d\n",error[3]);
  $stop;
end
endmodule


