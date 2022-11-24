import UIKit

//MARK: - 1 Protocols -

//Protocols are a way of describing what properties and methods something must have

protocol Identifiable
{
    var id: String { get set }
}

//We can’t create instances of that protocol but we can create a struct that conforms to it

struct User: Identifiable
{
    var id: String
}

//Function accepts any Identifiable object

func displayID(thing: Identifiable)
{
    print("My ID is \(thing.id)")
}

//MARK: - 2 Protocols -

protocol Payable
{
    func calculateWages() -> Int
}

protocol NeedsTraining
{
    func study()
}

protocol HasVacation
{
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation
{
    
}

//MARK: - 3 Extensions -

//Extensions allow to add methods to existing types, to make them do things they weren’t originally designed to do.

extension Int
{
    func squared() -> Int
    {
        return self * self
    }
}

let number = 8
number.squared()

// Swift doesn’t let to add stored properties in extensions, so we must use computed properties instead.

extension Int
{
    var isEven: Bool
    {
        return self % 2 == 0
    }
}

//MARK: - 4 Protocol extensions -

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

//Swift’s arrays and sets both conform to a protocol called Collection, so we can extend that
extension Collection
{
    func summarize()
    {
        print("There are \(count) of us:")

        for name in self
        {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

//MARK: - 5 Protocol-oriented programming -

protocol Identifiable2
{
    var id: String { get set }
    func identify()
}

extension Identifiable2
{
    func identify()
    {
        print("My ID is \(id).")
    }
}

struct User2: Identifiable2
{
    var id: String
}

let twostraws = User2(id: "twostraws")
twostraws.identify()
