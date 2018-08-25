module ALUControl (ALUOp, FuncCode, ALUCtl);
     input [1:0] ALUOp;
     input [5:0] FuncCode;
     output reg [3:0] ALUCtl;

     always @(*) begin
       case (ALUOp)
        'b 00: ALUCtl<= 2; //lW and SW
        'b 01: ALUCtl<= 6; //Branch
        'b 11: ALUCtl<= 15; //should not happen
        'b 10: //R-type
          case (FuncCode)
                32: ALUCtl<=2; // add
                34: ALUCtl<=6; //subtract
                36: ALUCtl<=0; // and
                37: ALUCtl<=1; // or
                39: ALUCtl<=12; // nor
                42: ALUCtl<=7; // slt
                default: ALUCtl<=15; // should not happen
            endcase
          endcase
      end
endmodule ///Pg 317

/*module beanch ();
    reg [1:0]ALUOp2;
    reg [5:0] FuncCode2;
    wire [3:0] ALUCtl2;
    initial begin
      $dumpfile("Calu.vcd"); $dumpvars;
      $monitor ("%g\t ALUCtl=%b",$time,ALUCtl2);
      #10 ALUOp2= 'b 10 ;FuncCode2=32;
      #10 $finish;
    end
    ALUControl control(ALUOp2,FuncCode2,ALUCtl2);
endmodule*/
