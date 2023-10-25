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