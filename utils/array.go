package utils

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

func Filter[T comparable](arr []T, filter func(item T) bool) []T {
	filtered := []T{}
	for _, item := range arr {
		if filter(item) {
			filtered = append(filtered, item)
		}
	}
	return filtered
}
