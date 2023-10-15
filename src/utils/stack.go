package utils

type Stack[T any] struct {
	items []T
}

func (s *Stack[T]) Push(item T) {
	s.items = append(s.items, item)
}

func (s *Stack[T]) Pop() T {
	max := len(s.items) - 1
	removed, items := s.items[max], s.items[:max]
	s.items = items
	return removed
}

func (s *Stack[T]) First() T {
	return s.items[len(s.items)-1]
}

func (s *Stack[T]) Final() T {
	return s.items[0]
}

func (s *Stack[T]) Array() []T {
	return s.items
}

func NewStack[T any]() Stack[T] {
	return Stack[T]{[]T{}}
}
