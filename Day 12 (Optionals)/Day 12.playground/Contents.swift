import UIKit

//MARK: - 1 Handling missing data -

var age: Int? = nil
age = 38

//MARK: - 2 Unwrapping optionals -

var name: String? = nil

//if there is no value inside of string, it will print "Missing name"
if let unwrapped = name
{
    print("\(unwrapped.count) letters")
}
else
{
    print("Missing name.")
}

//MARK: - 3 Unwrapping with guard -

//guard let will unwrap an optional, but if it finds nil inside it expects us to exit the function, loop, or condition we used it in.

func greet(_ name: String?)
{
    guard let unwrapped = name else
    {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}

//MARK: - 4 Force unwrapping -

//We should only force unwrap when it is 100% safe
let str = "5"
let num = Int(str)!

//MARK: - 5 Implicitly unwrapped optionals -

//We use this if we 100% that variable age2 will have a value in the future
let age2: Int! = nil

//MARK: - 6 Nil coalescing -

func username(for id: Int) -> String?
{
    if id == 1
    {
        return "Taylor Swift"
    }
    else
    {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"

//MARK: - 7 Optional chaining -

let names = ["John", "Paul", "George", "Ringo"]

//if first returns nil then Swift won’t try to uppercase it, and will set beatle to nil immediately
let beatle = names.first?.uppercased()

//MARK: - 8 Optional try -

enum PasswordError: Error
{
    case obvious
}

func checkPassword(_ password: String) throws -> Bool
{
    if password == "password"
    {
        throw PasswordError.obvious
    }

    return true
}

if let result = try? checkPassword("password")
{
    print("Result was \(result)")
}
else
{
    print("D'oh.")
}

try! checkPassword("sekrit")
print("OK!")

//MARK: - 9 Failable initializers -

let str2 = "5"
let num2 = Int(str)

struct Person
{
    var id: String

    init?(id: String)
    {
        if id.count == 9
        {
            self.id = id
        }
        else
        {
            return nil
        }
    }
}

//MARK: - 10 Type casting -

class Animal { }
class Fish: Animal { }

class Dog: Animal
{
    func makeNoise()
    {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets
{
    if let dog = pet as? Dog
    {
        dog.makeNoise()
    }
}
