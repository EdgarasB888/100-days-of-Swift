import UIKit

//MARK: - 1 - Arithmetic operators

let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore

let product = firstScore * secondScore
let divided = firstScore / secondScore

let remainder = 13 % secondScore

//MARK: - 2 - Operator overloading

let meaningOfLife = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

//MARK: - 3 - Compound assignment operators

var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"

//MARK: - 4 - Comparison operators

let thirdScore = 6
let fourthScore = 4

thirdScore == fourthScore
thirdScore != fourthScore

thirdScore < fourthScore
thirdScore >= fourthScore

"Taylor" <= "Swift"

//MARK: - 5 - Conditions

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21
{
    print("Blackjack!")
}

if firstCard + secondCard == 21
{
    print("Blackjack!")
}
else
{
    print("Regular cards")
}

if firstCard + secondCard == 2
{
    print("Aces – lucky!")
}
else if firstCard + secondCard == 21
{
    print("Blackjack!")
}
else
{
    print("Regular cards")
}

//MARK: - 6 - Combining conditions

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18
{
    print("Both are over 18")
}

if age1 > 18 || age2 > 18
{
    print("At least one is over 18")
}

//MARK: - 7 - The ternary operator

let thirdCard = 11
let fourthCard = 10
//prints "Cards are the same" if true and "Cards are different if false"
print(thirdCard == fourthCard ? "Cards are the same" : "Cards are different")

if firstCard == secondCard
{
    print("Cards are the same")
}
else
{
    print("Cards are different")
}

//MARK: - 8 - Switch statements

let weather = "sunny"

switch weather
{
    case "rain":
        print("Bring an umbrella")
    case "snow":
        print("Wrap up warm")
    case "sunny":
        print("Wear sunscreen")
    default:
        print("Enjoy your day!")
}

//MARK: - 9 - Range operators

let score2 = 85

switch score2
{
    case 0..<50:
        print("You failed badly.")
    case 50..<85:
        print("You did OK.")
    default:
        print("You did great!")
}
