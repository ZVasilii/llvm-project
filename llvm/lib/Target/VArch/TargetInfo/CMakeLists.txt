add_llvm_component_library(LLVMVArchInfo
  VArchTargetInfo.cpp

  LINK_COMPONENTS
  Support

  ADD_TO_COMPONENT
  VArch
  )
