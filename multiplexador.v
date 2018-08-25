module MultRegDst (In1,In2,Sel,Out1); //load9(0) and store(1)
    input [4:0] In1, In2; //four 32-bit inputs
    input Sel; //selector signal
    output reg [4:0] Out1;// 32-bit output
    always @(In1, In2, Sel) begin
        case (Sel)
            0: Out1 <= In1;
            1: Out1 <= In2;
        endcase
    end
endmodule

module MultALUSrc (In1,In2,Sel,Out2); //Imediato(1) e Registrador(0)
    input [31:0] In1, In2; //four 32-bit inputs
    input Sel; //selector signal
    output reg [31:0] Out2;// 32-bit output
    always @(In1, In2, Sel)
        case (Sel)
            0: Out2 <= In1;
            1: Out2 <= In2;
        endcase
endmodule

module MultMemtoReg (In1,In2,Sel,Out3); //Read(1) e Alu(0)
    input [31:0] In1, In2; //four 32-bit inputs
    input Sel; //selector signal
    output reg [31:0] Out3;// 32-bit output
    always @(In1, In2, Sel)
        case (Sel)
            1: Out3 <= In1;//0
            0: Out3 <= In2;//1
        endcase
endmodule

module MultBranch (In1,In2,Sel,Out4); //Branch(1) e Next(0)
    input [31:0] In1, In2; //four 32-bit inputs
    input Sel; //selector signal
    output reg [31:0] Out4;// Saída para proxima
    always @(In1, In2,  Sel)
        case (Sel)
            0: Out4 <= In1;
            1: Out4 <= In2;
        endcase
endmodule
