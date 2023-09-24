# Basic Structures
- Comments
    ```
    // Comment
    
    /*
    Multi-line comment
    */
    ```
- Groups
    ```
    // Anything inside of braces is a group, and has scope 
    {
        // code omitted
    }

    // Examples
    if true {

    }

    someFunc() {

    }
    ```
- Arrays
    ```
    // Arrays literals are made from the type, and filled with brackets
    float[] myArray = float[3.7, -6.4, 12.9, 5.0]
    ```
- Operation Assignment
    ```
    int x = 5

    // x = x + 2 
    x += 2
    ```
- Functions
    ```
    // func_name(params) (returns) {}
    add(int a, int b) (int) { // parameter: type name
        return a + b // return a value
    }
    
    varargs(int x, int y, string ...names, float z) {
        println((x + y) * z, ...names)
    }
    
    // Prints -33.6 John Jeff
    varargs(3, 5, "John", "Jeff", "Tim", -4.2)
    
    // Multiple return values
    combos(int a, int b, int c) (int, int, int, string) {
        return a + b, a + c, b + c, "Combos of $(a), $(b), $(c)"
    }
    
    // Underscores imply unused result
    // All ignored values must be explicit, so the last '_' is necessary
    firstCombo, _, thirdCombo, _ := combos(-6, 12, 5)
    
    // Prints 102
    println(firstCombo * thirdCombo)
    
    // Chaining using the pipe operator
    // Equivalent to: result := addExclamationMarks(substr(lower("John Cena"), 0, 4))
    result := "John Cena" |> lower() |> substr(0, 4) |> addExclamationMarks(3)
    
    // result = "john!!!"
    ```
- Inference
    ```
    // x is a float
    x := 8.9

    // pi and otherPi are both int[]'s
    pi := [3, 1, 4]
    otherPi := int[3, 1, 4, 1, 5]
    ```
- Type Cast
    ```
    // to_type<from_type>
    str_num := string<543> // str_num := "543"
    ```
- String Interpolation
    ```
    x := 5
    saying := "good morning"

    // Equivalent to 'println("I said " + string<saying> + " " + string<x> + " times!")'
    println("I said $(saying) $(x) times!")
    ```
- Classes
    ```
    // Person class
    class Person {
        // ! Design getter & setter syntax
        string name
        int    age
        int    days_old

        // Constructor, ~param => my.param = param
        Person(string ~name, int ~age) {
            // my => this
            my.days_old = age * 365
        }

        talk() {
            println("Hello, my name is $(my.name).")
        }

        // Define typecast, now string<Person> is possible
        to string {
            return "$(my.name), $(my.age) years old"
        }
    }

    // Extend classes
    class Student extends Person {
        int    grade
        string school

        // ! Add th / rd / nd / st suffixes after private/public syntax is created

        Student(string ~name, int ~age, int ~grade, string ~school) {}

        ~Student() {
            println("$(my.name) left $(my.school)")
        }

        // Override
        talk() {
            // Any parent calls must be explicit
            super.talk()
            println("I am a student at $(my.school), in grade $(my.grade).")
        }

        to string {
            // my.self and super.self return an actual object that can be passed through type casting and functions
            return "$(my.school) student, $(string<super.self>), grade $(my.grade)"
        }

        // extends automatically creates to Person conversion
    }

    class Vec3 {
        int x, y, z

        Vec3(int ~x, int ~y, int ~z) {}

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
    // Extend integers
    printFloat() {
        println(float<my>)
    } extends int

    x := 5
    x.printFloat() // prints "5.0"
    ```
- Enums 
    ```
    // Enum declaration
    enum Season {
        Winter
        Spring
        Summer
        Fall
    }

    enum Mood {
        Happy
        Sad
        Angry
    }

    // Illegal
    Season.Winter == Mood.Happy

    // Legal
    int<Season.Winter> == int<Mood.Happy> // true

    // Casting available
    Season<0> == Season.Winter // true

    // Compact Declaration
    enum Month {
        January; February; March; April; May; June; July; August; September; October; November; December
    }

    // Subcatagory of a enum
    enum WarmMonth from Month {
        May
        June
        July
        August
    }

    // True
    WarmMonth.June == Month.June
    ```
- Loops
    ```
    // For loop
    for x := 0; x < 5; x++ {
        println("#$(x)")
    }
    
    // While loop
    while x < 5 {
        x += 2
    }

    float sum = 0
    do {
        sum += prompt("What number?")
    } while sum < 100

    arr := [6, 5, -2, 8, -4, 0, -1]

    // Foreach / forin loop
    for el, i in arr {
        println("$(i). $(el)")
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

    // Ternary operator
    x := y < z ? x : 4
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