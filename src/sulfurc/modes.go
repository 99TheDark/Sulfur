package sulfurc

import "sulfur/src/utils"

type CompilerMode string

const (
	Run   CompilerMode = "run"
	Build CompilerMode = "build"
)

var Mode CompilerMode

func SetMode(mode string) {
	if !IsMode(mode) {
		utils.Panic("Invalid mode \"" + mode + "\"")
	}

	Mode = CompilerMode(mode)
}

func IsMode(mode string) bool {
	switch CompilerMode(mode) {
	case Run, Build:
		return true
	default:
		return false
	}
}
