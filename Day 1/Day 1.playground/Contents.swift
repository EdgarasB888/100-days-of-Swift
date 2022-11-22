import UIKit

//MARK: - 1 - Variables

var str = "Hello, playground"
str = "Goodbye"

//MARK: - 2 - Strings and integers

var age = 38

//Two of writing 8 million:
//1 way:
var population = 8000000
//2 way:
var population2 = 8_000_000

//MARK: - 3 - Multi-line strings

//string is actually displayed in multiple lines
var str1 = """
This goes
over multiple
lines
"""

//only code formatting, string is not displayed in multiple lines
var str2 = """
This goes \
over multiple \
lines
"""

//MARK: - 4 - Doubles and Booleans

var pi = 3.141
var awesome = true

//MARK: - 5 - String interpolation

var score = 85
var str3 = "Your score was \(score)"

var results = "The test results are here: \(str3)"

//MARK: - 6 - Constants

//can't change value of let. If we want to change values, we have to use var instead
let taylor = "swift"

//MARK: - 7 - Type annotations

//Swift automatically assigns types to variables
let str4 = "Hello, playground"

//But if we want to be type specific, we can assign them ourselves
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true

let cpuType = "Intel"
var depth = 10000
