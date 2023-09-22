package libc

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

var Printf *ir.Func

func Builtins(mod *ir.Module) {
	Printf = mod.NewFunc("printf", types.I32, ir.NewParam("format", types.I8Ptr))
	Printf.Sig.Variadic = true
}
