`include "Mips.v"

module testeBench();
  reg rst;
  reg clock;

  initial begin
    $dumpfile("testeBench.vcd"); $dumpvars;
    //$monitor ("%g\t Reset=%b Clk=%b",$time,rst,clock);
    #0 clock=0;
    #1 rst=1;
    #1 rst=0;
  end

  Mips test(.clk(clock),.rst(rst));

  always begin
    #1 clock = ~clock;
  end
endmodule //testeBenc
