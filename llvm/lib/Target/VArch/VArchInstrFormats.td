//===-- VArchInstrFormats.td - VArch Instruction Formats -----*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

// ~~~~~~~~~~~~~~~~~~~~~~
// ~~~From RISC-V spec~~~
// ~~~~~~~~~~~~~~~~~~~~~~

class InstFormat<bits<5> val> {
  bits<5> Value = val;
}

def InstFormatR      : InstFormat<0>;
def InstFormatI      : InstFormat<1>;
def InstFormatS      : InstFormat<2>;
def InstFormatB      : InstFormat<3>;
def InstFormatU      : InstFormat<4>;
def InstFormatJ      : InstFormat<5>;

class VArchOpcode<string name, bits<7> val> {
  string Name = name;
  bits<7> Value = val;
}

class VArchInst<dag outs, dag ins, string opcodestr, string argstr,
             list<dag> pattern, InstFormat format>
    : Instruction {

  let Namespace = "VArch";
  let DecoderNamespace = "VArch";
  let Size = 4;

  field bits<32> Inst;

  bits<7> Opcode = 0;
  let Inst{6-0} = Opcode;

  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString = opcodestr # "\t" # argstr;
  let Pattern = pattern;
}

class VArchInstR<bits<7> funct7, bits<3> funct3, VArchOpcode opcode, dag outs,
              dag ins, string opcodestr, string argstr>
    : VArchInst<outs, ins, opcodestr, argstr, [], InstFormatR> {
  bits<5> rs2;
  bits<5> rs1;
  bits<5> rd;

  let Inst{31-25} = funct7;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
}


class VArchInstI<bits<3> funct3, VArchOpcode opcode, dag outs, dag ins,
              string opcodestr, string argstr>
    : VArchInst<outs, ins, opcodestr, argstr, [], InstFormatI> {
  bits<12> imm12;
  bits<5> rs1;
  bits<5> rd;

  let Inst{31-20} = imm12;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
}


class VArchInstS<bits<3> funct3, VArchOpcode opcode, dag outs, dag ins,
              string opcodestr, string argstr>
    : VArchInst<outs, ins, opcodestr, argstr, [], InstFormatS> {
  bits<12> imm12;
  bits<5> rs2;
  bits<5> rs1;

  let Inst{31-25} = imm12{11-5};
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = imm12{4-0};
  let Opcode = opcode.Value;
}

class VArchInstB<bits<3> funct3, VArchOpcode opcode, dag outs, dag ins,
              string opcodestr, string argstr>
    : VArchInst<outs, ins, opcodestr, argstr, [], InstFormatB> {
  bits<12> imm12;
  bits<5> rs2;
  bits<5> rs1;

  let Inst{31} = imm12{11};
  let Inst{30-25} = imm12{9-4};
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-8} = imm12{3-0};
  let Inst{7} = imm12{10};
  let Opcode = opcode.Value;
}

class VArchInstU<VArchOpcode opcode, dag outs, dag ins, string opcodestr,
              string argstr>
    : VArchInst<outs, ins, opcodestr, argstr, [], InstFormatU> {
  bits<20> imm20;
  bits<5> rd;

  let Inst{31-12} = imm20;
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
}

class VArchInstJ<VArchOpcode opcode, dag outs, dag ins, string opcodestr,
              string argstr>
    : VArchInst<outs, ins, opcodestr, argstr, [], InstFormatJ> {
  bits<20> imm20;
  bits<5> rd;

  let Inst{31} = imm20{19};
  let Inst{30-21} = imm20{9-0};
  let Inst{20} = imm20{10};
  let Inst{19-12} = imm20{18-11};
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
}

def OPC_LOAD      : VArchOpcode<"LOAD",      0b0000011>;
def OPC_LOAD_FP   : VArchOpcode<"LOAD_FP",   0b0000111>;
def OPC_CUSTOM_0  : VArchOpcode<"CUSTOM_0",  0b0001011>;
def OPC_MISC_MEM  : VArchOpcode<"MISC_MEM",  0b0001111>;
def OPC_OP_IMM    : VArchOpcode<"OP_IMM",    0b0010011>;
def OPC_AUIPC     : VArchOpcode<"AUIPC",     0b0010111>;
def OPC_OP_IMM_32 : VArchOpcode<"OP_IMM_32", 0b0011011>;
def OPC_STORE     : VArchOpcode<"STORE",     0b0100011>;
def OPC_STORE_FP  : VArchOpcode<"STORE_FP",  0b0100111>;
def OPC_CUSTOM_1  : VArchOpcode<"CUSTOM_1",  0b0101011>;
def OPC_AMO       : VArchOpcode<"AMO",       0b0101111>;
def OPC_OP        : VArchOpcode<"OP",        0b0110011>;
def OPC_LUI       : VArchOpcode<"LUI",       0b0110111>;
def OPC_OP_32     : VArchOpcode<"OP_32",     0b0111011>;
def OPC_MADD      : VArchOpcode<"MADD",      0b1000011>;
def OPC_MSUB      : VArchOpcode<"MSUB",      0b1000111>;
def OPC_NMSUB     : VArchOpcode<"NMSUB",     0b1001011>;
def OPC_NMADD     : VArchOpcode<"NMADD",     0b1001111>;
def OPC_OP_FP     : VArchOpcode<"OP_FP",     0b1010011>;
def OPC_OP_V      : VArchOpcode<"OP_V",      0b1010111>;
def OPC_CUSTOM_2  : VArchOpcode<"CUSTOM_2",  0b1011011>;
def OPC_BRANCH    : VArchOpcode<"BRANCH",    0b1100011>;
def OPC_JALR      : VArchOpcode<"JALR",      0b1100111>;
def OPC_JAL       : VArchOpcode<"JAL",       0b1101111>;
def OPC_SYSTEM    : VArchOpcode<"SYSTEM",    0b1110011>;
def OPC_CUSTOM_3  : VArchOpcode<"CUSTOM_3",  0b1111011>;
