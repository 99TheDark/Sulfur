package ast

type Type string

const (
	VoidType     = ""
	IntegerType  = "int"
	UnsignedType = "uint"
	FloatType    = "float"
	BooleanType  = "bool"
	StringType   = "string"
	ByteType     = "byte"
	ComplexType  = "complex"
	AnyType      = "any"
)

func (t Type) String() string {
	if t == VoidType {
		return "no type"
	}
	return string(t)
}
