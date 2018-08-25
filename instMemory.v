module instMemory (RAdress,instruction,rst,clk);
  input wire [31:0] RAdress;
  output wire [31:0] instruction;
  input wire rst;
  input wire clk;

  integer o;

  reg [31:0] PC [255:0];

  initial begin
    for (o=0; o<255; o = o + 4) begin
      PC[o]=0;
    end
  end

  assign instruction=PC[RAdress];

  always @ (posedge clk) begin
    if (rst == 1) begin
      $readmemb("input/Fatorial.bin",PC);
    end
  end
endmodule // instMemory

/*module beanchInst ();
    reg [31:0] RAdress;
    wire [31:0] instruction;
    reg rst;
    initial begin
      $dumpfile("inst.vcd"); $dumpvars;
      $monitor ("%g\t Radress=%b nstruction=%b rst=%b",$time,RAdress,instruction,rst);
      #10 rst=1;
      #10 rst=0;
      #10 RAdress=0;
      #10 RAdress=4;
      #10 RAdress=8;
      #50 $finish;
    end
    instMemory a(RAdress,instruction,rst);
endmodule // beanch*/
