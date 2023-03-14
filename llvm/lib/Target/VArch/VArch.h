//===-- VArch.h - Top-level interface for VArch representation ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in
// the LLVM VArch back-end.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VArch_VArch_H
#define LLVM_LIB_TARGET_VArch_VArch_H

#include "MCTargetDesc/VArchMCTargetDesc.h"
#include "llvm/Target/TargetMachine.h"

namespace llvm {
  class VArchTargetMachine;
  class FunctionPass;

} // end namespace llvm;

#endif
