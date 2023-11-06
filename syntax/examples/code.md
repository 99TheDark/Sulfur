import math

int x = 5
let y = x * 3 // type inference

if y > x {
    println("Hi there!")
}

func add(int x, int y) (int) {
    return x + y
}

println(add(x, y))

let z: string = "Hello, world"
z += "!"

println(math::sin(x ^ y)) // -0.97332247668