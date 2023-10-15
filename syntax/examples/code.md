import math

int x = 5
y := x * 3 // type inference

if y > x {
    println("Hi there!")
}

func add(int x, int y) (int) {
    return x + y
}

println(add(x, y))

z := "Hello, world"
z += "!"

println(math::sin(x ^ y)) // -0.97332247668