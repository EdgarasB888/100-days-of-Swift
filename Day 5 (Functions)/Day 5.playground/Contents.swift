import UIKit

var greeting = "Hello, playground"

//MARK: - 1 Writing functions -

func printHelp()
{
    let message = """
    Welcome to MyApp!

    Run this app inside a directory of images and
    MyApp will resize them all into thumbnails
    """
    
    print(message)
}

printHelp()

//MARK: - 2 Accepting parameters -

func square(number: Int)
{
    print(number * number)
}

square(number: 8)

//MARK: - 3 Returning values -

func squareFunc(number: Int) -> Int
{
    return number * number
}

let result = squareFunc(number: 8)
print(result)

//MARK: - 4 Parameter labels -

func sayHello(to name: String)
{
    print("Hello, \(name)!")
}

sayHello(to: "Taylor")

//MARK: - 5 Omitting parameter labels -

func greet(_ person: String)
{
    print("Hello, \(person)!")
}

greet("Taylor")

//MARK: - 6 Default parameters -

func greet(_ person: String, nicely: Bool = true)
{
    if nicely == true
    {
        print("Hello, \(person)!")
    }
    else
    {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)

//MARK: - 7 Variadic functions -

print("Haters", "gonna", "hate")

func square(numbers: Int...)
{
    for number in numbers
    {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)

//MARK: - 7 Writing throwing functions -

enum PasswordError: Error
{
    case obvious
}

func checkPassword(_ password: String) throws -> Bool
{
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

//MARK: - 7 Running throwing functions -

do
{
    try checkPassword("password")
    print("That password is good!")
}
catch
{
    print("You can't use that password.")
}

//MARK: - 8 InOut parameters -

//inout parameters can change inside function
func doubleInPlace(number: inout Int)
{
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
