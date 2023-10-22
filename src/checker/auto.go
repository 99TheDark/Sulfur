package checker

import (
	"sulfur/src/ast"
	"sulfur/src/builtins"
	. "sulfur/src/errors"
	"sulfur/src/typing"
)

var order []typing.Type = []typing.Type{
	typing.Void,
	typing.Boolean,
	typing.Byte,
	typing.Unsigned,
	typing.Integer,
	typing.Float,
	typing.Complex,
	typing.String,
	typing.Any,
}

// Minimum acceptable type to automatically cast bools to
const boolAcceptable = 7

func (c *checker) AutoInfer(a, b typing.Type, srcA, srcB ast.Expr) (builtins.TypeConvSignature, bool) {
	if a == typing.Void {
		Errors.Error("Cannot operator on values with no type", srcA.Loc())
	}
	if b == typing.Void {
		Errors.Error("Cannot operator on values with no type", srcB.Loc())
	}

	idxA, idxB := -1, -1
	foundA, foundB := false, false
	for i, typ := range order {
		if typ == a {
			foundA = true
			idxA = i
		}
		if typ == b {
			foundB = true
			idxB = i
		}

		if foundA && foundB {
			break
		}
	}

	if !foundA {
		Errors.Error("Cannot yet convert classes", srcA.Loc())
	}
	if !foundB {
		Errors.Error("Cannot yet convert classes", srcB.Loc())
	}

	var from, to typing.Type
	var exitIdx int
	var exitSrc ast.Expr
	if idxA < idxB {
		from, to = a, b
		exitIdx = idxB
		exitSrc = srcA
	} else {
		from, to = b, a
		exitIdx = idxA
		exitSrc = srcB
	}

	if from == typing.Boolean && exitIdx < boolAcceptable {
		return builtins.TypeConvSignature{}, false
	}

	for i, conv := range builtins.TypeConvs {
		if conv.From == from && conv.To == to {
			c.autoconvs[exitSrc] = conv
			conv.Uses++
			c.program.TypeConvs[i] = conv

			return conv, true
		}
	}
	return builtins.TypeConvSignature{}, false
}

func (c *checker) AutoSingleInfer(have, want typing.Type, src ast.Expr) (builtins.TypeConvSignature, bool) {
	idxHave, idxWant := -1, -1
	foundHave, foundWant := false, false
	for i, typ := range order {
		if typ == have {
			foundHave = true
			idxHave = i
		}
		if typ == want {
			foundWant = true
			idxWant = i
		}

		if foundHave && foundWant {
			break
		}
	}

	if idxWant > idxHave {
		for i, conv := range builtins.TypeConvs {
			if conv.From == have && conv.To == want {
				c.autoconvs[src] = conv
				conv.Uses++
				c.program.TypeConvs[i] = conv

				return conv, true
			}
		}
	}

	return builtins.TypeConvSignature{}, false
}

func AutoSwitch(srcA, srcB typing.Type, conv builtins.TypeConvSignature) (typing.Type, typing.Type) {
	if srcA == conv.From {
		return conv.To, srcB
	} else if srcB == conv.From {
		return srcA, conv.To
	} else {
		return srcA, srcB
	}
}
