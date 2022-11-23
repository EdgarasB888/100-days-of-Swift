import UIKit

//MARK: - 1 Creating your own classes -

//a class must have it's initializers

class Dog
{
    var name: String
    var breed: String

    init(name: String, breed: String)
    {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

//MARK: - 2 Class inheritance -

class Poodle: Dog
{
    init(name: String)
    {
        super.init(name: name, breed: "Poodle")
    }
}

//MARK: - 3 Overriding methods -

class Dog2
{
    func makeNoise()
    {
        print("Woof!")
    }
}

class Poodle2: Dog2
{
    override func makeNoise()
    {
        print("Yip!")
    }
}

let poppy2 = Poodle2()
poppy2.makeNoise()

//MARK: - 4 Final classes -

//Final classes cannot be inherited
final class Dog3
{
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

//MARK: - 5 Copying objects -

//When we copy a struct, both the original and the copy are different things - changing one won't change the other
//When we copy a class, both the original and the copy point to the same thing, so changing one does change the other

class Singer
{
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

//if it were a struct, it would still print "Taylor Swift"
print(singer.name)

//MARK: - 6 Deinitializers -

class Person
{
    var name = "John Doe"

    init()
    {
        print("\(name) is alive!")
    }

    func printGreeting()
    {
        print("Hello, I'm \(name)")
    }
    
    deinit
    {
        print("\(name) is no more!")
    }
}

for _ in 1...3
{
    let person = Person()
    person.printGreeting()
}

//MARK: - 7 Mutability -

class Singer2
{
    let name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)

