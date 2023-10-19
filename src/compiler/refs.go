package compiler

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

type ref_bundle struct {
	typ   types.Type
	ptr   *types.PointerType
	ref   *ir.Func
	deref *ir.Func
}
