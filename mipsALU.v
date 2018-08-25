

module MIPSALU (ALUctl, A, B, ALUOut, Zero);
     input [3:0] ALUctl;
     input [31:0] A,B;
     output reg [31:0] ALUOut;
     output Zero;

     assign Zero = (ALUOut==0); //Zero is true if ALUOut is 0; goes anywhere
     always @(ALUctl, A, B) begin//reevaluate if these change
        case (ALUctl)
             0: ALUOut <= A & B;
             1: ALUOut <= A | B;
             2: ALUOut <= A + B;
             6: ALUOut <= A - B;//negativo tratar
             7: ALUOut <= A < B ? 1:0;
             12: ALUOut <= ~(A | B); // result is nor
             default: ALUOut <= 0; //default to 0, should not happen;
         endcase
       end
endmodule

/*module beanchMipsALU ();
    reg [1:0]ALUOp;
    reg [5:0] FuncCode;
    wire [3:0] ALUCtl;
    initial begin
      $dumpfile("Calu.vcd"); $dumpvars;
      $monitor ("%g\t ALUCtl=%b",$time,ALUCtl);
      #10 ALUOp= 'b 10 ;FuncCode=34;

    end
    ALUControl control(.ALUOp(ALUOp),.FuncCode(FuncCode),.ALUCtl(ALUCtl));
    reg[31:0] A,B;
    wire [31:0] ALUOut;
    initial begin
      #10 A=1;B=0;
      #10 A=1;B=1;
      #10 A=0;B=1;
      #10 $finish;
    end
    MIPSALU AlU(ALUCtl,A,B,ALUOut,Zero);
endmodule // beanch*/
