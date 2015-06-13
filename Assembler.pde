class AssemblerInstruction {
  String code;        // mneunomic for instruction, e.g "MOV"
  byte   opcode;      // instruction op code
  boolean noArgs;
  String description; // help/description of instruction.

  AssemblerInstruction(String _code, byte _opcode, boolean _noArgs, String _description) {
    code = _code;
    opcode = _opcode;
    description = _description;
    noArgs = _noArgs;
  }
}



class Assembler {
  AssemblerInstruction[] INSTRUCTIONS = {
    new AssemblerInstruction("MOV A<-", byte(0), false, "MOVE ARG TO A"), 
    new AssemblerInstruction("MOV B<-", byte(1), false, "MOVE ARG TO B"), 
    new AssemblerInstruction("SWAP A, B", byte(2), true, "SWAP REGS A AND B"),
    new AssemblerInstruction("JMP <-", byte(3), false, "JMP A ADDRS"),
  };

  AssemblerInstruction DATA = new AssemblerInstruction("DATA", byte(-1), false, "DATA");

  boolean validInstruction(byte a) {
    return ((short) (a & 255) < INSTRUCTIONS.length);
  }

  String dis(byte a, byte  b) {
    if (validInstruction(a)) {
      AssemblerInstruction i = INSTRUCTIONS[a];
      if (i.noArgs) {
        return String.format("%s", i.code);
      } else {
        return String.format("%s %02X (%d)", i.code, b, b);
      }
    } else {
      return String.format("DATA %X, %X", a, b);
    }
  }
}

