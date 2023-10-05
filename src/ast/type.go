package ast

type Type string

const (
	VoidType    = ""
	IntegerType = "int"
	FloatType   = "float"
	BooleanType = "bool"
	StringType  = "string"
	ComplexType = "complex"
	AnyType     = "any"
)

func (t Type) String() string {
	if t == VoidType {
		return "no type"
	}
	return string(t)
}
