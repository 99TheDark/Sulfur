package compiler

import (
	"sulfur/src/ast"
	"sulfur/src/lexer"
	"sulfur/src/location"
	"sulfur/src/typing"

	"github.com/llir/llvm/ir"
	"github.com/llir/llvm/ir/constant"
	"github.com/llir/llvm/ir/enum"
	"github.com/llir/llvm/ir/types"
	"github.com/llir/llvm/ir/value"
)

// TODO: Clean up all the refence code to be more concise and fight with each other less
func (g *generator) genBasicRawIden(vari *ast.Variable) value.Value {
	bl := g.bl

	if vari.Referenced || vari.References {
		bundle := g.refs[vari.Type]
		ref := vari.Value

		src := ref
		if vari.Status != ast.Parameter {
			load := bl.NewLoad(bundle.ptr, ref)
			load.Align = 8
			src = load
		}

		ptr := bl.NewGetElementPtr(bundle.typ, src, Zero, Zero)
		ptr.InBounds = true

		valptr := bl.NewLoad(g.llptr(vari.Type), ptr)
		valptr.Align = 8
		return valptr
	} else {
		return vari.Value
	}
}

func (g *generator) genBasicIden(vari *ast.Variable) value.Value {
	bl := g.bl

	val := g.genBasicRawIden(vari)

	if vari.Status == ast.Parameter && !vari.Referenced && !vari.References {
		return val
	}

	load := bl.NewLoad(g.lltyp(vari.Type), val)
	load.Align = ir.Align(g.align(vari.Type))
	return load
}

func (g *generator) genBasicDecl(name string, typ types.Type, val value.Value, loc *location.Location) {
	bl := g.bl

	vari := g.top.Lookup(name, loc)
	alloca := g.topfun.Decls[vari]

	if vari.References {
		store := bl.NewStore(val, alloca)
		store.Align = 8

		vari.Value = alloca
	} else if vari.Referenced {
		bundle := g.refs[vari.Type]

		call := bl.NewCall(bundle.newref, val)
		store := bl.NewStore(call, alloca)
		store.Align = 8

		vari.Value = alloca
	} else {
		bl.NewStore(val, alloca)
		vari.Value = alloca
	}
}

func (g *generator) genBasicAssign(name string, val value.Value, loc *location.Location) {
	bl := g.bl
	vari := g.top.Lookup(name, loc)

	if vari.Referenced || vari.References {
		iden := g.genBasicRawIden(vari)

		store := bl.NewStore(val, iden)
		store.Align = 8
	} else {
		bl.NewStore(val, vari.Value)
	}
}

func (g *generator) genBasicBinaryOp(left, right value.Value, op lexer.TokenType, typ typing.Type) value.Value {
	bl := g.bl
	switch op {
	case lexer.Addition:
		switch typ {
		case typing.String: // = string + string
			call := bl.NewCall(g.srcBinop(lexer.Addition, typing.String, typing.String).Ir, left, right)
			return call
		case typing.Integer, typing.Unsigned: // = int + int, uint + uint
			return bl.NewAdd(left, right)
		case typing.Float: // = float + float
			return bl.NewFAdd(left, right)
		}
	case lexer.Subtraction:
		switch typ {
		case typing.Integer, typing.Unsigned: // = int - int, uint - uint
			return bl.NewSub(left, right)
		case typing.Float: // = float - float
			return bl.NewFSub(left, right)
		}
	case lexer.Multiplication:
		switch typ {
		case typing.Integer, typing.Unsigned: // = int * int, uint * uint
			return bl.NewMul(left, right)
		case typing.Float: // = float * float
			return bl.NewFMul(left, right)
		}
	case lexer.Division:
		switch typ {
		case typing.Integer: // = int / int
			return bl.NewSDiv(left, right)
		case typing.Unsigned: // = uint / uint
			return bl.NewUDiv(left, right)
		case typing.Float: // = float / float
			return bl.NewFDiv(left, right)
		}
	case lexer.Modulus:
		switch typ {
		case typing.Integer: // = int % int
			return bl.NewSRem(left, right)
		case typing.Unsigned: // = uint % uint
			return bl.NewURem(left, right)
		case typing.Float: // = float % float
			return bl.NewFRem(left, right)
		}
	case lexer.Or:
		switch typ {
		case typing.Integer, typing.Unsigned, typing.Boolean: // = int | int, uint | uint, bool | bool
			return bl.NewOr(left, right)
		}
	case lexer.And:
		switch typ {
		case typing.Integer, typing.Unsigned, typing.Boolean: // = int | int, uint | uint, bool | bool
			return bl.NewAnd(left, right)
		}
	case lexer.RightShift:
		switch typ {
		case typing.Integer: // = int >> int
			return bl.NewAShr(left, right)
		case typing.Unsigned: // = uint >> uint
			return bl.NewLShr(left, right)
		}
	case lexer.LeftShift:
		switch typ {
		case typing.Integer: // = int << int
			return bl.NewShl(left, right)
		case typing.Unsigned: // = uint << uint
			return bl.NewShl(left, right)
		}
	}

	return Zero
}

func (g *generator) genBasicUnaryOp(val value.Value, op lexer.TokenType, typ typing.Type) value.Value {
	bl := g.bl
	switch op {
	case lexer.Subtraction:
		switch typ {
		case typing.Integer: // = -int
			return bl.NewSub(Zero, val)
		case typing.Float: // = -float
			return bl.NewFSub(FZero, val)
		}
	case lexer.Not:
		switch typ {
		case typing.Integer, typing.Unsigned: // = !int, !uint
			return bl.NewXor(val, NegOne)
		case typing.Boolean: // = !bool
			return bl.NewICmp(enum.IPredEQ, val, Zero)
		}
	case lexer.CountLeadingZeros:
		switch typ {
		case typing.Unsigned:
			return bl.NewCall(g.intrinsics["clz"], val, constant.False)
		}
	case lexer.CountTrailingZeros:
		switch typ {
		case typing.Unsigned:
			return bl.NewCall(g.intrinsics["ctz"], val, constant.False)
		}
	}

	return Zero
}

func (g *generator) genBasicComparison(left, right value.Value, comp lexer.TokenType, typ typing.Type) value.Value {
	bl := g.bl
	switch comp {
	case lexer.LessThan:
		switch typ {
		case typing.Integer: // = int < int
			return bl.NewICmp(enum.IPredSLT, left, right)
		case typing.Unsigned: // = uint < uint
			return bl.NewICmp(enum.IPredULT, left, right)
		case typing.Float: // = float < float
			return bl.NewFCmp(enum.FPredULT, left, right)
		}
	case lexer.GreaterThan:
		switch typ {
		case typing.Integer: // = int > int
			return bl.NewICmp(enum.IPredSGT, left, right)
		case typing.Unsigned: // = uint > uint
			return bl.NewICmp(enum.IPredUGT, left, right)
		case typing.Float: // = float > float
			return bl.NewFCmp(enum.FPredUGT, left, right)
		}
	case lexer.LessThanOrEqualTo:
		switch typ {
		case typing.Integer: // = int <= int
			return bl.NewICmp(enum.IPredSLE, left, right)
		case typing.Unsigned: // = uint <= uint
			return bl.NewICmp(enum.IPredULE, left, right)
		case typing.Float: // = float <= float
			return bl.NewFCmp(enum.FPredULE, left, right)
		}
	case lexer.GreaterThanOrEqualTo:
		switch typ {
		case typing.Integer: // = int >= int
			return bl.NewICmp(enum.IPredSGE, left, right)
		case typing.Unsigned: // = uint >= uint
			return bl.NewICmp(enum.IPredUGE, left, right)
		case typing.Float: // = float >= float
			return bl.NewFCmp(enum.FPredUGE, left, right)
		}
	case lexer.EqualTo:
		switch typ {
		case typing.Integer, typing.Unsigned, typing.Boolean: // = int == int, uint == uint, bool == bool
			return bl.NewICmp(enum.IPredEQ, left, right)
		case typing.Float: // = float == float
			return bl.NewFCmp(enum.FPredUEQ, left, right)
		}
	case lexer.NotEqualTo:
		switch typ {
		case typing.Integer, typing.Unsigned, typing.Boolean: // = int != int, uint != uint, bool != bool
			return bl.NewICmp(enum.IPredNE, left, right)
		case typing.Float: // = float != float
			return bl.NewFCmp(enum.FPredUNE, left, right)
		}
	}

	return Zero
}

func (g *generator) genBasicTypeConv(val value.Value, from, to typing.Type) value.Value {
	bl := g.bl
	conv := g.srcConv(string(from), string(to))

	if from == to {
		return val
	}

	if conv.Complex {
		return bl.NewCall(conv.Ir, val)
	} else {
		typ := g.lltyp(conv.To)

		switch from {
		case typing.Integer:
			switch to {
			case typing.Unsigned:
				return val
			case typing.Float:
				return bl.NewSIToFP(val, typ)
			case typing.Boolean:
				return bl.NewICmp(enum.IPredNE, val, Zero)
			}
		case typing.Unsigned:
			switch to {
			case typing.Integer:
				return val
			case typing.Float:
				return bl.NewUIToFP(val, typ)
			case typing.Boolean:
				return bl.NewICmp(enum.IPredNE, val, Zero)
			}
		case typing.Float:
			switch to {
			case typing.Integer:
				return bl.NewFPToSI(val, typ)
			case typing.Boolean:
				return bl.NewFCmp(enum.FPredONE, val, FZero)
			}
		case typing.Boolean:
			switch to {
			case typing.Integer:
				return bl.NewZExt(val, typ)
			case typing.Float:
				return bl.NewSIToFP(bl.NewZExt(val, types.I32), typ)
			}
		}
	}

	return Zero
}

func (g *generator) genBasicStruct(typ types.Type, fields ...value.Value) value.Value {
	bl := g.bl

	alloca := bl.NewAlloca(typ)
	alloca.Align = 8
	for i, field := range fields {
		ptr := bl.NewGetElementPtr(
			typ,
			alloca,
			Zero,
			constant.NewInt(types.I32, int64(i)),
		)
		ptr.InBounds = true

		store := bl.NewStore(
			field,
			ptr,
		)
		store.Align = 8
	}

	load := bl.NewLoad(typ, alloca)
	load.Align = 8

	return load
}
