`include "dataMemory.v"
`include "Controlador.v"
`include "instMemory.v"
`include "multiplexador.v"
`include "registradores.v"
`include "ControladorALU.v"
`include "SignExtend.v"
`include "mipsALU.v"


module Mips(clk,rst,adress,instruction,ALUOut);
  input rst;
  input clk;
  output reg [31:0]adress;
  reg [31:0]adress_4;
  output wire [31:0]instruction;

  always @ (posedge clk) begin
    if(rst) begin
       adress=0;
    end
	 else if (jump) begin
      adress = aux;
    end
	 else begin
      adress = out4;
    end
  end

  instMemory inst(.RAdress(adress),.instruction(instruction),
                  .rst(rst),.clk(clk));

  //Variaveis da Instrução
  wire [5:0] op;
  wire [4:0] rs;
  wire [4:0] rt;
  wire [4:0] rd;
  wire [15:0] imediato;
  wire [5:0] funct;

  assign op=instruction[31:26];
  assign rs=instruction[25:21];
  assign rt=instruction[20:16];
  assign rd=instruction[15:11];
  assign imediato=instruction[15:0];
  assign funct=instruction[5:0];

  //Variaveis do Controle
  wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, jump;
  wire [1:0]ALUOp;

  Control control(.Inst(op),.RegDst(RegDst),
                  .Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),
                  .ALUOp(ALUOp),.MemWrite(MemWrite),.ALUSrc(ALUSrc),
                  .RegWrite(RegWrite),.jump(jump),.clk(clk)); //clk control


  wire [4:0]out1;
  MultRegDst mux1(.In1(rt),.In2(rd),.Sel(RegDst),.Out1(out1));//out=write register

  wire [31:0] Data1;
  wire [31:0] Data2;
  wire [31:0] out3;

  registerfile register(.Read1(rs),.Read2(rt),.WriteReg(out1),
                        .WriteData(out3),.RegWrite(RegWrite),
                        .Data1(Data1),.Data2(Data2),.clock(clk));//out=write register //clk(out1) //Esse clockmem n deveria ser clk?

  wire [31:0]outsing;

  SignExtend sing(.in(imediato),.out(outsing));


  reg [31:0]aux;//imediato*4
  reg [31:0]beq;

   always @ ( negedge clk ) begin
      adress_4 = adress + 3'b100;
    end

    always @ (negedge clk) begin
      aux = imediato << 2;//imediato*4
      beq = adress_4+aux; //função da alu de Cima /// antes era adress+4+aux
    end

    always @ (posedge clk) begin
      if (instruction == 0) begin
        $finish;
		  //acender led
      end
    end

  wire [31:0] out2;
  wire [3:0] ALUCtl;

  ALUControl aluControl(.ALUOp(ALUOp),.FuncCode(funct),
                        .ALUCtl(ALUCtl));//clk(Data1 || Data2)


  MultALUSrc mux2(.In1(Data2),.In2(outsing),
                  .Sel(ALUSrc),.Out2(out2));//clk(Data1 || Data2)

  output [31:0]ALUOut;
  wire Zero;


  MIPSALU alu(.ALUctl(ALUCtl),.A(out2),
              .B(Data1),.ALUOut(ALUOut),.Zero(Zero));//clk(Out2)

  wire [31:0]ReadData;

  dataMemory dataMem(.addr(ALUOut),.write_data(Data2),
                     .memwrite(MemWrite),.memread(MemRead),
                     .clk(clk),.read_data(ReadData));

  MultMemtoReg mux3(.In1(ReadData),.In2(ALUOut),
                   .Sel(MemtoReg),.Out3(out3));//clk(ALUOut)

  wire [31:0] out4;
  reg PcControl;

  always @ (negedge clk) begin
     PcControl = Zero && Branch;
  end

  MultBranch mux4(.In1(adress_4),.In2(beq),
                  .Sel(PcControl),.Out4(out4));


endmodule // Mips;
