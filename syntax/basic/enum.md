## Enums
Enumerables, or enums are very useful for defining constants. To create an enum, you use the `enum` keyword, the name of the enum, and a block including its values. For example,
```
enum Season {
    Winter
    Spring
    Summer
    Fall
}
```
or
```
enum Mood {
    Happy
    Sad
    Angry
}
```
To get the value of an enum, you use a dot between the enum name and the value name, like `Seasons.Fall` or `Seasons.Spring`. 

The values of an enum are by default integers, starting with zero and incrementing by one each time. Any integral type will automatically do this, like unsigned integers and bytes. 

Since enums are each their own type, something like `Season.Winter == Mood.Happy` is illegal.

Enums can be any type, and have any value which it can be casted to and from. In the last two examples, the values of the enums are integers, so you can write `int!(Mood.Sad)` and `Mood!(2)`.

To declare the values of an enum to be something else, simply write it like a constant assignment, as follows:
```
enum FantasyRace {
    Human = "human"
    Elf   = "elf"
    Orc   = "orc"
    Dwarf = "dwarf"
}
```
In this case, the values of the `FantasyRace` enum are strings. If one value is assigned, all must be assigned. This means something like
```
enum Status {
    Accepted
    Rejected
    Pending
    None = -1
}
```
is illegal.

Similarly to classes, you can have subcatagories of enums. If we had an enum `Month` for example,
```
enum Month {
    January; February; March;     April;   May;      June
    July;    August;   September; October; November; December
}
```
we could create a subcatagory, like `WarmMonth` for example.
```
enum WarmMonth from Month {
    May
    June
    July
    August
}
```
In this case, no enum values can be assigned. You simply specify the included elements in the subcatagory.

In Sulfur, enums can have more than just one value; they can have multiple by simply adding a comma between each value alonside giving a name, which can also be done with only single values in an enum. This can be very useful for matching many other things to an enum without using giant `match` cases or `if`-`else` chains. 

Under the hood, Sulfur stores the enums as something all together, so giving underlying type(s) just allows type conversion(s) between the `enum` and another type.

An example might be with the US states:
```
enum US_State {
    Delaware = name: "Delaware", abbr: "DE", entry: 1
    Pennsylvania = name: "Pennsylvania", abbr: "PA", entry: 2
    NewJersey = name: "New Jersey", abbr: "NJ", entry: 3
}
```
You may also want to format everything to line up
```
enum US_State {
    Delaware     = name: "Delaware",     abbr: "DE", entry: 1
    Pennsylvania = name: "Pennsylvania", abbr: "PA", entry: 2
    NewJersey    = name: "New Jersey",   abbr: "NJ", entry: 3
}
```
If an enum gets too long, you may even want to split it onto multiple lines per value:
```
enum US_State {
    Delaware = 
        name: "Delaware",     
        abbreviation: "DE", 
        entry: 1,
        population: 1003000u

    Pennsylvania = 
        name: "Pennsylvania", 
        abbreviation: "PA", 
        entry: 2,
        population: 9267000u
        
    NewJersey = 
        name: "New Jersey",   
        abbreviation: "NJ", 
        entry: 3,
        population: 12960000u
}
```
To access named enums, just access the named values like fields of a `class` or `struct`.
```
let delaware: US_State  = US_State.Delaware
let pop_of_del: uint    = US_State.Delaware.population
let name_of_del: string = delaware.name
```