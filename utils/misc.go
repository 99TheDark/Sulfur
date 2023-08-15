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

func IndexOf[T comparable](arr []T, el T) int {
	for i, item := range arr {
		if item == el {
			return i
		}
	}
	return -1
}

func Contains[T comparable](arr []T, el T) bool {
	return IndexOf(arr, el) != -1
}

func Remove[T comparable](arr []T, idx int) []T {
	return append(arr[:idx], arr[idx+1:]...)
}
