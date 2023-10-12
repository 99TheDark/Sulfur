package compiler

import (
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/types"
)

var NegOne = constant.NewInt(types.I32, int64(-1))
var Zero = constant.NewInt(types.I32, int64(0))
var One = constant.NewInt(types.I32, int64(1))
var Two = constant.NewInt(types.I32, int64(2))

var FZero = constant.NewFloat(types.Float, float64(0))
var FOne = constant.NewFloat(types.Float, float64(1))
