add_llvm_component_group(VArch)

set(LLVM_TARGET_DEFINITIONS VArch.td)
tablegen(LLVM VArchGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM VArchGenInstrInfo.inc -gen-instr-info)
add_public_tablegen_target(VArchCommonTableGen)

add_llvm_target(VArchCodeGen
  VArchTargetMachine.cpp

  LINK_COMPONENTS
  Analysis
  AsmPrinter
  CodeGen
  Core
  MC
  VArchDesc
  VArchInfo
  SelectionDAG
  Support
  Target
  GlobalISel

  ADD_TO_COMPONENT
  VArch
  )

add_subdirectory(TargetInfo)
add_subdirectory(MCTargetDesc)
