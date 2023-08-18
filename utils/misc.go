package utils

func Clamp(num *float64, min, max float64) bool {
	switch {
	case *num > max:
		*num = max
		return true
	case *num < min:
		*num = min
		return true
	default:
		return false
	}
}

func Min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func Max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
