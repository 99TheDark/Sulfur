# Prototyping Syntax
- Arrays
    ```
    // Arrays literals are made from the type, and filled with brackets
    float[] myArray = float[3.7, -6.4, 12.9, 5.0]
    ```
- Classes
    ```
    // Person class
    class Person {
        // All fields and methods must have a visibility modifier
        val string name
        pub int    age
        pri int    days_old

        // Constructor, ~param means param is automatically initialized
        new(string ~name, int ~age) {
            // Prefix with a dot to access from the current instance
            .days_old = age * 365
        }

        // del() is a destructor

        // DEfine a method
        pub talk() {
            println("Hello, my name is $(.name).")
        }

        // Define type conversion, now string!(Person) is possible
        // Type conversion and operator overloading is always public, so no pub keyword is necessary
        to string {
            return "$(.name), $(.age) years old"
        }
    }

    // Extend classes
    class Student extends Person {
        // Static variable
        val stat MaxGrade = 12

        pub uint   grade
        pub string school

        pub new(string ~name, int ~age, uint ~grade, string ~school) {}

        pub del() {
            println("$(.name) left $(.school)")
        }

        // Override
        pub talk() {
            // Any parent calls must be explicit
            super.talk()
            println("I am a student at $(.school), in grade $(.grade).")
        }

        pri suffixedGrade() (string) {
            end := .grade % 10
            suffix := "th"
            if .grade <= 10 | .grade > 20 {
                if end == 1 {
                    suffix = "st"
                } else if end == 2 {
                    suffix = "nd"
                } else if end == 3 {
                    suffix = "rd"
                }
            }

            return string!(.grade) + suffix
        }

        to string {
            // TODO: Different syntax for super?
            // .self and super.self return an actual object that can be passed through type convertion and functions
            return "$(.school) student, $(string!(super.self)), grade $(.grade)"
        }

        // extends automatically creates to Person conversion
    }

    class Vec3 {
        pub int x, y, z

        pub new(int ~x, int ~y, int ~z)

        // Must have either one or two parameters (unary/binary operator)
        operator + (Vec3 a, Vec3 b) (Vec3) {
            return Vec3(a.x + b.x, a.y + b.y, a.z + b.z)
        }

        operator - (Vec3 a, Vec3 b) (Vec3) {
            return Vec3(a.x - b.x, a.y - b.y, a.z - b.z)
        }

        // Cross product
        operator * (Vec3 a, Vec3 b) (Vec3) {
            return Vec3(
                a.y * b.z - a.z * b.y, 
                a.z * b.x - a.x * b.z, 
                a.x * b.y - a.y * b.x
            )
        }

        /* 
        This is makes: 
        Vec3: * (int, Vec3) (Vec3) 
        int: * (Vec3, int) (Vec3)
        int: * (int, Vec3) (Vec3)
        int: * (Vec3, int) (int)
        int: * (int, Vec3) (int)
        all illegal to write, as order on binary operations doesn't matter, 
        and operations cannot get two results
        */
        // Scalar multiplication
        operator * (Vec3 vec, int scalar) (Vec3) {
            return Vec3(vec.x * scalar, vec.y * scalar, vec.z * scalar)
        }

        // Scalar division
        operator / (Vec3 vec, int scalar) (Vec3) {
            return Vec3(vec.x / scalar, vec.y / scalar, vec.z / scalar)
        }
    }

    Person person = new Student()
    println(person is Student) // true
    println(person is Person)  // true
    println(person is Vec3)    // false
    ```
- Extending Types
    ```
    // TODO: Change this syntax to prototyping / extending classes
    // Extend integers
    func printFloat() {
        // Self is the object itself
        println(float!(.self)) 
    } extends int

    x := 5
    x.printFloat() // prints "5.0"
    ```
- Loops
    ```
    // For loop
    for x := 0; x < 5; x++ {
        println("#$(x + 1)")
    }
    
    // While loop
    while x < 5 {
        x += 2
    }

    float sum = 0
    do {
        sum += prompt("What number?")
    } while sum < 100

    arr := int[6, 5, -2, 8, -4, 0, -1]

    // For each loop
    for el, i in arr {
        println("$(i). $(el)")
    }

    // For in range loop
    for i in -1:5 {
        println(i)
    }
    ```
- Conditionals
    ```
    // If statement
    if y * x < z {
        println("Case A")
    } else if y > x {
        println("Case B")
    } else {
        println("Case C")
    }

    // The => operator creates a one-line group {}
    if x > 3 => println("$(x) is bigger than 3")

    // Ternary operator
    x := y < z ? x : 4
    ```
- Match
    ```
    age := 12
    match age {
        case 0 => println("baby")
        case 1 {
            println("one")
            fallthrough // goes to next pattern
        }
        case 2:4 => println("toddler)
        case 5, 6, 7 => println("five, six or seven")
        else => println("some other age")
    }

    boolean := true
    bitBoolean := match boolean {
        true => yield 1
        false => yield 0
    }
    ```
- Destructuring
    ```
    letters := ["a", "b", "c", "d", "e", "f"]
    
    // Similar to varargs
    first, second, ...middle, last := letters
    
    /*
    first = "a" 
    second = "b" 
    middle = ["c", "d", "e"]
    last = "f"
    */
    ```
- Null Handling
    ```
    // x is an int? (int or null)
    int x? = null

    // Illegal
    string x = null

    // Legal
    x? := 5

    // Illegal
    x? := null

    // y becomes 4 if x is null, otherwise is x
    // y is an int
    y := x ?? 4
    ```
- Error Handling
        ```
    // Similar to enum syntax
    error FileError {
        FileNotFound,
        AccessDenied
    }

    read(string path) (string) throws FileError {
        if !fileExists() {
            throw FileError.FileNotFound
        }
        if !hasAccess() {
            throw FileError.AccessDenied
        }

        return safeRead(path)
    }

    text := try read("./assets/text/secret.txt") catch {
        FileError.FileNotFound {
            println("File Error: File not found")
            yield "404"
        }
        FileError.AccessDenied {
            println("File Error: Access deined")
        }
    }
    ```