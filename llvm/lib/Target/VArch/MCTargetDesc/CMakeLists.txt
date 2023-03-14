add_llvm_component_library(LLVMVArchDesc
  VArchMCTargetDesc.cpp

  LINK_COMPONENTS
  MC
  VArchInfo
  Support

  ADD_TO_COMPONENT
  VArch
  )
