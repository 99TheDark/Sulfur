int x = 5
let y = x * 3 // type inference

if y > x {
    println("Hi there!")
}

func add(int x, int y) (int) {
    return x + y
}

println(add(x, y))

z := "Hello, world"
z += "!"