package parser

import (
	. "sulfur/errors"
	"sulfur/typing"
)

// Infer
func (x Program) InferType() string {
	x.Contents.InferType()
	return ""
}
func (x Block) InferType() string {
	for _, child := range x.Body {
		child.InferType()
	}
	return ""
}
func (x Identifier) InferType() string {
	v := get(x, x.Parent, x.Symbol)
	x.Type.Name, x.Type.Underlying = v.Type, v.Underlying
	return v.Type
}
func (x Datatype) InferType() string {
	dt := x.Datatype.Symbol
	x.Type.Name, x.Type.Underlying = dt, typing.Underlying(dt)
	return dt
}
func (x Declaration) InferType() string {
	typ := confirm(x, x.Datatype.Symbol, x.Value.InferType())
	x.Type.Name, x.Type.Underlying = typ, typing.Underlying(typ)

	variable := typing.NewVar(x.Type.Name, x.Type.Underlying, typing.Local)
	create(x.Variable, x.Variable.Symbol, *variable)

	return typ
}
func (x ImplicitDeclaration) InferType() string {
	typ := x.Value.InferType()
	x.Type.Name, x.Type.Underlying = typ, typing.Underlying(typ)

	variable := typing.NewVar(x.Type.Name, x.Type.Underlying, typing.Local)
	create(x.Variable, x.Variable.Symbol, *variable)

	return typ
}
func (x Assignment) InferType() string {
	return ""
}
func (x List) InferType() string {
	for _, child := range x.Values {
		child.InferType()
	}
	return ""
}
func (x BinaryOperation) InferType() string {
	typ := confirm(x, x.Left.InferType(), x.Right.InferType())
	x.Type.Name, x.Type.Underlying = typ, typing.Underlying(typ)
	return typ
}
func (x Comparison) InferType() string {
	confirm(x, x.Left.InferType(), x.Right.InferType())

	x.Type.Name, x.Type.Underlying = "bool", typing.Bool
	return "bool"
}
func (x FunctionLiteral) InferType() string {
	*x.Locator.Functions = append(*x.Locator.Functions, &x)

	for _, parameter := range x.Params.Values {
		if param, ok := parameter.(Datatype); ok {
			param.InferType()

			variable := typing.NewVar(
				param.Type.Name,
				param.Type.Underlying,
				typing.Param,
			)
			x.Contents.Scope.Vars[param.Variable.Symbol] = *variable
		} else {
			Errors.Error("Non-parameter in function parameters", parameter.Location())
		}
	}
	x.Contents.InferType()

	x.Type.Name, x.Type.Underlying = "func", typing.Func
	return "func"
}
func (x FunctionCall) InferType() string {
	fun := find(x)
	if fun == nil {
		if x.Name.Symbol == "putchar" {
			return string(typing.Func)
		}

		Errors.Error("'"+x.Name.Symbol+"' is not defined", x.Name.Loc)
		return ""
	} else {
		// TODO: Check parameter types
		return fun.Type.Name
	}
}
func (x IntegerLiteral) InferType() string {
	x.Type.Name, x.Type.Underlying = "int", typing.Int
	return "int"
}
func (x FloatLiteral) InferType() string {
	x.Type.Name, x.Type.Underlying = "float", typing.Float
	return "float"
}
func (x BoolLiteral) InferType() string {
	x.Type.Name, x.Type.Underlying = "bool", typing.Bool
	return "bool"
}
func (x StringLiteral) InferType() string {
	*x.Locator.Strings = append(*x.Locator.Strings, &x)

	x.Type.Name, x.Type.Underlying = "string", typing.String
	return "string"
}
func (x Return) InferType() string { // tricky
	x.Value.InferType()
	return ""
}
func (x IfStatement) InferType() string {
	cond := x.Condition.InferType()
	if cond != "bool" {
		Errors.Error("Condition must be a boolean", x.Condition.Location())
	}

	x.Then.InferType()
	x.Else.InferType()
	return ""
}

// Misc
func confirm(Expression Expression, types ...string) string {
	f := types[0]
	if len(types) < 2 {
		return f
	}

	for _, el := range types {
		if el != f {
			Errors.Error("Mismatch of '"+el+"' to '"+f+"'", Expression.Location())
		}
	}
	return f
}

func link(expr Expression, parent typing.Scope, program Program) {
	if iden, ok := expr.(Identifier); ok {
		*iden.Parent = parent
	} else {
		newParent := parent
		if fun, ok := expr.(FunctionLiteral); ok {
			*fun.Locator = program
		} else if call, ok := expr.(FunctionCall); ok {
			*call.Locator = program
		} else if str, ok := expr.(StringLiteral); ok {
			*str.Locator = program
		} else if block, ok := expr.(Block); ok {
			*block.Scope.Parent = parent
			newParent = block.Scope
		}

		for _, child := range expr.Children() {
			link(child, newParent, program)
		}
	}
}

func find(call FunctionCall) *FunctionLiteral {
	for _, fun := range *call.Locator.Functions {
		if fun.Name.Symbol == call.Name.Symbol {
			return fun
		}
	}
	return nil
}

func TypeCheck(ast Program) Program {
	link(ast, ast.Contents.Scope, ast)
	ast.InferType()
	return ast
}
