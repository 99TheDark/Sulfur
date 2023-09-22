package libc

import (
	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/types"
)

var PutChar *ir.Func
var Funcs map[string]*ir.Func = make(map[string]*ir.Func)

func Builtins(mod *ir.Module) {
	PutChar = mod.NewFunc("putchar", types.Void, ir.NewParam("", types.I8))

	Funcs["putchar"] = PutChar
}
