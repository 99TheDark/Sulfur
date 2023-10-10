package typing

type Type string

const (
	Void     = ""
	Integer  = "int"
	Unsigned = "uint"
	Float    = "float"
	Boolean  = "bool"
	String   = "string"
	Byte     = "byte"
	Complex  = "complex"
	Any      = "any"
)

func (t Type) String() string {
	if t == Void {
		return "no type"
	}
	return string(t)
}
