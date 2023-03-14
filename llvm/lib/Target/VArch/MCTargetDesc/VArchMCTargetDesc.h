//===-- VArchMCTargetDesc.h - VArch Target Descriptions -----------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides VArch specific target descriptions.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VArch_MCTARGETDESC_VArchMCTARGETDESC_H
#define LLVM_LIB_TARGET_VArch_MCTARGETDESC_VArchMCTARGETDESC_H

#include "llvm/Support/DataTypes.h"

#include <memory>

namespace llvm {
class Target;
class Triple;

extern Target TheVArchTarget;

} // End llvm namespace

// Defines symbolic names for VArch registers.  This defines a mapping from
// register name to register number.
#define GET_REGINFO_ENUM
#include "VArchGenRegisterInfo.inc"

// Defines symbolic names for the VArch instructions.
#define GET_INSTRINFO_ENUM
#include "VArchGenInstrInfo.inc"

#endif
