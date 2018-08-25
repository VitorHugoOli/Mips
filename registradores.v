
module registerfile (Read1,Read2,WriteReg,
                     WriteData,RegWrite,
                     Data1,Data2,clock);
  input [4:0] Read1,Read2,WriteReg; // the register numbers to read or write
  input [31:0] WriteData; // data to write
  input RegWrite,clock; // the write control the clock to trigger write

  output [31:0] Data1, Data2; // the register values read

  reg [31:0] registers [31:0]; // 32 registers each 32 bits long

  initial begin
    registers[0] <= 0;
    registers[1] <= 0;
    registers[2] <= 0;
    registers[3] <= 0;
    registers[4] <= 0;
    registers[5] <= 0;
    registers[6] <= 0;
    registers[7] <= 0;
    registers[8] <= 0;//t0
    registers[9] <= 0;//t1
    registers[10] <= 1;//t2
    registers[11] <= 0;//t3
    registers[12] <= 0;//t4
    registers[13] <= 0;//t5
    registers[14] <= 0;//t6
    registers[15] <= 0;//t7
    registers[16] <= 0;//s0
    registers[17] <= 0;//s1
    registers[18] <= 5;//s2
    registers[19] <= 0;//s3
    registers[20] <= 0;//s4
    registers[21] <= 10;//s5
    registers[22] <= 0;//s6
    registers[23] <= 0;//s7
    registers[24] <= 0;
    registers[25] <= 0;
    registers[26] <= 0;
    registers[27] <= 0;
    registers[28] <= 0;
    registers[29] <= 0;
    registers[30] <= 0;
    registers[31] <= 0;
  end

  assign Data1 = registers[Read1];
  assign Data2 = registers[Read2];

  always @(posedge clock) begin   // write the register with new value if Regwrite is high
    if (RegWrite) begin
      registers[WriteReg] <= WriteData;
    end

    /*$monitor ("writeData=%d\nWriteReg=%d\n reg[0]=%d\n reg[1]=%d\n reg[2]=%d\n reg[3]=%d\n reg[4]=%d\n reg[5]=%d\n reg[6]=%d\n reg[7]=%d\n reg[8]=%d\n reg[9]=%d\nreg[10]=%d\nreg[11]=%d\nreg[12]=%d\nreg[13]=%d\nreg[14]=%d\nreg[15]=%d\nreg[16]=%d\nreg[17]=%d\nreg[18]=%d\nreg[19]=%d\nreg[20]=%d\nreg[21]=%d\nreg[22]=%d\nreg[23]=%d\nreg[24]=%d\nreg[25]=%d\nreg[26]=%d\nreg[27]=%d\nreg[28]=%d\nreg[29]=%d\nreg[30]=%d\nreg[31]=%d\n"
                              ,WriteData, WriteReg
                              , registers[0]
                              , registers[1]
                              , registers[2]
                              , registers[3]
                              , registers[4]
                              , registers[5]
                              , registers[6]
                              , registers[7]
                              , registers[8]
                              , registers[9]
                              , registers[10]
                              , registers[11]
                              , registers[12]
                              , registers[13]
                              , registers[14]
                              , registers[15]
                              , registers[16]
                              , registers[17]
                              , registers[18]
                              , registers[19]
                              , registers[20]
                              , registers[21]
                              , registers[22]
                              , registers[23]
                              , registers[24]
                              , registers[25]
                              , registers[26]
                              , registers[27]
                              , registers[28]
                              , registers[29]
                              , registers[30]
                              , registers[31]);*/
  end

endmodule
