package compiler

import (
	"sulfur/src/utils"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/value"
)

type context struct {
	parent     *context
	fun        *ir.Func
	ret        value.Value
	exits      utils.Stack[*ir.Block]
	blockcount int
}
