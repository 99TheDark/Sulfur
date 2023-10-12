package utils

type Stack[T any] struct {
	items []T
}

func (s *Stack[T]) Push(item T) {
	s.items = append(s.items, item)
}

func (s *Stack[T]) Pop() T {
	removed, items := s.items[0], s.items[1:]
	s.items = items
	return removed
}

func NewStack[T any]() Stack[T] {
	return Stack[T]{[]T{}}
}
