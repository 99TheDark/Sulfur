package utils

type Queue[T any] struct {
	items []T
}

func NewQueue[T any](items []T) Queue[T] {
	return Queue[T]{items}
}

func (q *Queue[T]) Consume() *T {
	removed := q.items[0]
	q.items = q.items[1:]
	return &removed
}

func (q *Queue[T]) Next() (*T, bool) {
	if q.Empty() {
		return nil, false
	} else {
		return q.Consume(), true
	}
}

func (q *Queue[T]) Empty() bool {
	return len(q.items) == 0
}
