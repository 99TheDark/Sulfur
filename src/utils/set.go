package utils

type Set[T comparable] struct {
	items map[T]bool
}

func (s *Set[T]) Add(item T) {
	s.items[item] = true
}

func (s *Set[T]) Remove(item T) {
	if s.Has(item) {
		delete(s.items, item)
	}
}

func (s *Set[T]) Has(item T) bool {
	_, ok := s.items[item]
	return ok
}

func (s *Set[T]) Array() []T {
	arr := []T{}
	for item := range s.items {
		arr = append(arr, item)
	}
	return arr
}

func NewSet[T comparable]() Set[T] {
	return Set[T]{
		make(map[T]bool),
	}
}
