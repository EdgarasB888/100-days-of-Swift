import UIKit

//MARK: - 1 - Arrays

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
//displays John Lennon
beatles[0]
//displays Paul McCartney
beatles[1]
//displays George Harrison
beatles[2]
//displays Ringo Starr
beatles[3]
//bad idea, crashes Swift
//beatles[9]

//MARK: - 2 - Sets

//Sets don't store items in any order like arrays
//All items in a set have to be unique

let colors = Set(["red", "green", "blue"])
//Duplicates get ignored
let colors2 = Set(["red", "green", "blue", "red", "blue"])

//MARK: - 3 - Tuples

//Tuples allow to store several values together in a single value
//Differences from arrays:
//1) you can't add or remove items from a tuple, they are fixed size
//2) you can't change the type of items in a tuple; they always have the same types they were created with
//3) you can access items in a tuple using numerical positions or by naming them, but Swift won't let to read numbers or names that do not exist

var name = (first: "Taylor", last: "Swift")
name.0
name.first

//MARK: - 4 - Arrays vs sets vs tuples

//If we need a specific, fixed collection of related values where each item has a precise position or name, we should use a tuple
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

//If we need a collection of values that must be unique or we need to be able to check whether a specific item is in there very quickly, we should use a set
let set = Set(["aardvark", "astronaut", "azalea"])

//If we need a collection of values that can contain duplicates, or the order of the items matters, we should use an array
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

//MARK: - 5 - Dictionaries

//We get data from them using a key identifier

let heights =
[
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

//This is how we get the data
heights["Taylor Swift"]

//MARK: - 6 - Dictionary default values

let favoriteIceCream =
[
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Paul"]

//We can provide dictionary a value if we request a missing key
favoriteIceCream["Charlotte", default: "Unknown"]

//MARK: - 7 - Creating empty collections

//empty dictionary example
var teams = [String: String]()
//another way to create a empty dictionary
var scores = Dictionary<String, Int>()
//then we add a new value
teams["Paul"] = "Red"

//empty array example
var results = [Int]()
//another way to create an empty array
//var results2 = Array<Int>()
//then we add new values
results.append(10)
results.append(11)

//empty set examples
var words = Set<String>()
var numbers = Set<Int>()

//MARK: - 8 - Enumerations

enum Result
{
    case success
    case failure
}

let result4 = Result.failure

//MARK: - 8 - Enum associated values

enum Activity
{
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

//MARK: - 9 - Enum raw values

enum Planet: Int
{
    case mercury = 1 //counting starts from 1 instead of 0
    case venus
    case earth
    case mars
}

let Earth = Planet(rawValue: 2)
