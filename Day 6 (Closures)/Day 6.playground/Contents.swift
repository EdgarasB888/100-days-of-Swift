import UIKit

//MARK: - 1 Creating basic closures -

//Swift lets us use functions just like any other type such as strings and integers.
//This means we can create a function and assign it to a variable, call that function using that variable, and even pass that function into other functions parameters.

let driving =
{
    print("I'm driving in my car")
}

driving()

//MARK: - 2 Accepting parameters in a closure -

//We have to put parameters in the closure but we put them first and then write in after
let driving2 =
{
    (place: String) in
    print("I'm going to \(place) in my car")
}

//One of the differences between functions and closures is that we don’t use parameter labels when running closures.
driving2("London")

//MARK: - 3 Returning values from a closure -

let drivingWithReturn =
{
    (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

//MARK: - 4 Closures as parameters -

func travel(action: () -> Void)
{
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)

//MARK: - 5 Trailing closure syntax -

//We can also use trailing closure syntax instead of doing it like it line 47
travel()
{
    print("I'm driving in my car")
}

//MARK: - 6 Using closures as parameters when they accept parameters -

func travel(action: (String) -> Void)
{
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel
{
    (place: String) in
    print("I'm going to \(place) in my car")
}

//MARK: - 7 Using closures as parameters when they return values -

func travel(action: (String) -> String)
{
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel
{
    (place: String) -> String in
    return "I'm going to \(place) in my car"
}

//MARK: - 8 Shorthand parameter names -

travel
{
    "I'm going to \($0) in my car"
}

//MARK: - 8 Closures with multiple parameters -

func travel(action: (String, Int) -> String)
{
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

//MARK: - 8 Returning closures from functions -

func travel() -> (String) -> Void
{
    return
    {
        print("I'm going to \($0)")
    }
}

let result = travel()
result("London")

let result2 = travel()("London")

//MARK: - 9 Capturing values -

func travel2() -> (String) -> Void
{
    var counter = 1

    return
    {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

result("London")
result("London")
result("London")
