module Control(Inst, RegDst, Branch,
               MemRead, MemtoReg, ALUOp,
               MemWrite, ALUSrc, RegWrite
               ,jump, clk);

  input [5:0] Inst;
  output reg [1:0] ALUOp;
  output reg RegDst,Branch,MemRead;
  output reg MemtoReg,MemWrite,ALUSrc,RegWrite,jump;
  input wire clk;

  initial begin
    jump = 0;
  end

  always @ (Inst) begin
    case(Inst)
        'b 000000: begin
            RegDst <= 1;
            Branch <= 0;
            jump = 0;
            MemRead <= 0;
            MemtoReg <= 0;
            ALUOp <= 'b 10;
            MemWrite <= 1;
            ALUSrc <= 0;
            RegWrite <= 1;
          end
        'b 100011: begin
            RegDst <= 0;
            Branch <= 0 ;
            jump = 0;
            MemRead <= 1;
            MemtoReg <= 1;
            ALUOp <= 'b 00;
            MemWrite <= 0;
            ALUSrc <= 1;
            RegWrite <= 1;
          end
        'b 101011: begin
            Branch <= 0;
            MemRead <= 0;
            jump = 0;
            ALUOp <= 'b 00;
            MemWrite <= 1;
            ALUSrc <= 1;
            RegWrite <= 0;
          end
        'b 000100: begin
            Branch <= 1;
            MemRead <=0;
            jump = 0;
            ALUOp <= 'b 01;
            MemWrite <= 0;
            ALUSrc <= 0;
            RegWrite <= 0;
          end
        'b 000010: begin
            Branch <= 0;
            jump = 1;
            MemRead <=0;
            ALUOp <= 'b 00;
            MemWrite <= 0;
            ALUSrc <= 0;
            RegWrite <= 0;
          end
          default : begin
            RegDst <= 0;
            Branch <= 0;
            jump = 0;
            MemRead <= 0;
            MemtoReg <= 0;
            ALUOp <= 'b 00;
            MemWrite <= 0;
            ALUSrc <= 0;
            RegWrite <= 0;
          end
      endcase
    end
endmodule //control #Pg 323 #Slide 5-22

/*module beanchCtrl ();
    reg [5:0] Inst;
    wire [1:0] ALUOp;
    wire RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
    initial begin
      $dumpfile("Control.vcd"); $dumpvars;
      #10 Inst= 'b 000000;
      #20 Inst='b 100011;
      #10 Inst='b 101011;
      #20 Inst='b 000100;
      #10 Inst='b 000101;
      #20 Inst='b 000000;
      #10 $finish;
    end
    Control cntr(Inst, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
endmodule // beanch*/
