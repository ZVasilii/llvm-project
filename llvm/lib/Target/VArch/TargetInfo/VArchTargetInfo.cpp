//===-- VArchTargetInfo.cpp - VArch Target Implementation -------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "VArch.h"
#include "llvm/IR/Module.h"
#include "llvm/MC/TargetRegistry.h"
using namespace llvm;

Target llvm::TheVArchTarget;

extern "C" void LLVMInitializeVArchTargetInfo() {
  RegisterTarget<Triple::varch,
                 /*HasJIT=*/false>
      X(TheVArchTarget, "VArch", "VArch RISC-Vasilii arch", "VArch");
}
