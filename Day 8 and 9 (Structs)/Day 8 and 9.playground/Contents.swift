import UIKit

//MARK: - 1 Creating your own structs -

struct Sport
{
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn tennis"

//MARK: - 2 Computed properties -

struct Sport2
{
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String
    {
        if isOlympicSport
        {
            return "\(name) is an Olympic sport"
        }
        else
        {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)


//MARK: - 3 Property observers -

struct Progress
{
    var task: String
    var amount: Int
    {
        //We can als use WillSet, but that is rarely used
        didSet
        {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

//MARK: - 4 Methods -

struct City
{
    var population: Int

    func collectTaxes() -> Int
    {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

//MARK: - 5 Mutating methods -

struct Person
{
    var name: String

    mutating func makeAnonymous()
    {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

//MARK: - 6 Properties and methods of strings -

let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())

//MARK: - 6 Properties and methods of arrays -
var toys = ["Woody"]

print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz")
print(toys.sorted())
toys.remove(at: 0)

//MARK: - 6 Initializers -

struct User
{
    var username: String
    
    init()
    {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"

//MARK: - 7 Referring to the current instance -

struct Person2
{
    var name: String

    init(name: String)
    {
        print("\(name) was born!")
        self.name = name
    }
}

//MARK: - 8 Lazy properties -

struct FamilyTree
{
    init()
    {
        print("Creating family tree!")
    }
}

struct Person3
{
    var name: String
    lazy var familyTree = FamilyTree() //will only be created when first accessed

    init(name: String)
    {
        self.name = name
    }
}

var ed = Person(name: "Ed")

//MARK: - 9 Static properties and methods -

struct Student
{
    var name: String
    //this variable will be shared accross all instances of the struct
    static var classSize = 0

    init(name: String)
    {
        self.name = name
        Student.classSize += 1
    }
}

let ed2 = Student(name: "Ed")
let taylor = Student(name: "Taylor")

print(Student.classSize)

//MARK: - 10 Access control -

struct Person4
{
    private var id: String

    init(id: String)
    {
        self.id = id
    }
    
    func identify() -> String
    {
            return "My social security number is \(id)"
    }
}

let ed3 = Person4(id: "12345")
print(ed3.identify())
