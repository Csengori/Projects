//: Playground - noun: a place where people can play

import UIKit

//Find n'th Digit of a Number
//func findDigit(_ num:Int, _ nth: Int) -> Int {
//    let temp: [Int] = [num].flatMap{String($0)}.flatMap{Int(String($0))}.reversed()
//    //let temp: [Int] = siwft3(num)
//    var selectedNumber = 0
//    if nth <= 0 {
//        selectedNumber = -1
//    }
//    if nth > temp.count {
//        selectedNumber = 0
//    }
//    if nth <= temp.count && nth > 0 {
//        selectedNumber = temp[nth - 1]
//        abs(selectedNumber)
//    }
//    return selectedNumber
//}

func findDigit(_ num:Int, _ nth: Int) -> Int {
    let number = abs(num)
    guard nth > 0 else { return -1}
    guard nth > 1 else {return  number % 10}
    guard number > 0 else { return 0 }
    return findDigit(number / 10, nth - 1)
}

//
//func siwft3(_ num: Int) -> [Int]{
//    let numbers: String = "\(num)"
//    return numbers.characters.flatMap{Int(String($0))}.reversed()
//}

findDigit(6429, 3)
findDigit(-1234, 2)
findDigit(678998, 0)
findDigit(65, 0)
findDigit(-456, 4)

//Stringy Strings
func Stringy(_ size: Int) -> String {
    //    var tempDisasterCounter = 0
    //    var tempDisasterOutput: [String] = []
    //    repeat {
    //        if tempDisasterCounter % 2 == 0 {
    //            tempDisasterOutput.append("0")
    //            tempDisasterCounter += 1
    //        } else {
    //            tempDisasterOutput.append("1")
    //            tempDisasterCounter += 1
    //        }
    //    }while tempDisasterCounter < size
    //
    //    return tempDisasterOutput.reversed().joined()
    let numbers = (0 ..< size ).map{String(($0 + 1) % 2)}
    return numbers.joined()
}
Stringy(4)

//Opposite number
func opposite(number: Double) -> Double {
    return -number
}

opposite(number: -3)
opposite(number: 3)

//String repeat
func repeatStr(_ n: Int, _ string: String) -> String {
    //    var tempStuff: String = ""
    //    var counter = n
    //    repeat {
    //        tempStuff += string
    //        counter -= 1
    //    }
    //        while counter > 0
    //    if n == 0 {
    //        tempStuff = ""
    //    }
    //    return tempStuff
    return String(repeating: string, count: n)
}

repeatStr(9, "hello")

//Transportation on vacation
func RentalCarCost(_ days: Int) -> Int {
    let rentalPrice = days * 40
    if days >= 3 && days < 7 {
        return rentalPrice - 20
    } else if days >= 7 {
        return rentalPrice - 50
    }else {
        return rentalPrice
    }
}

RentalCarCost(8)

//Switch it up aka aids switch
func switchItUp(_ number: Int) -> String {
    switch number {
    case 1:
        return "One"
    case 2:
        return "Two"
    case 3:
        return "Three"
    case 4:
        return "Four"
    case 5:
        return "Five"
    case 6:
        return "Six"
    case 7:
        return "Seven"
    case 8:
        return "Eight"
    case 9:
        return "Nine"
    default:
        return "Zero"
    }
}

switchItUp(9)

//Even or Odd
func evenOrOdd(_ number:Int) -> String {
    return number % 2 == 0 ? "Even" : "Odd"
}

///Convert number to reversed array of digits
func digitize(_ num:Int) -> [Int] {
    let temp: String = "\(num)"
    let array = temp.flatMap{Int(String($0))}
    return array
    //    let temp = num.array
    //    return temp.reversed()
}

func digitize2(_ num:Int) -> [Int] {
    return [num].flatMap{String($0)}.flatMap{Int(String($0))}.reversed()
}

//func siwft3(_ num: Int) -> [Any]{
//    let numbers: String = "\(num)"
//    return numbers.characters.flatMap{Int(String($0))}.reversed()
//}

//extension Int {
//    var array: [Int] {
//        return String(self).flatMap{Int(String($0))}
//    }
//}

//siwft3(45762893920)

digitize2(45762893920)
digitize2(234)
digitize(234)

//Functional addition
func add(_ n: Int) -> ((Int) -> Int) {
    func addOne(_ k: Int) -> Int {
        return k + n
    }
    return addOne(_:)
}

func addOneLiner(_ n: Int) -> ((Int) -> Int){
    return {return ($0 + n)}
}

addOneLiner(3)(4)
add(3)(4)

//Calculate BMI
func bmi(_ weight: Int, _ height: Double) -> String {
    let bmi = Double(weight) / (height * height)
    switch bmi {
    case let x where x < 18.5:
        return "Underweight"
    case let x where x <= 25.0:
        return "Normal"
    case let x where x <= 30.0 :
        return "Overweight"
    default:
        return "obese"
    }
}

bmi(185, 50)

//Dollars and Cents
func formatMoney(_ val:Double) -> String {
    return  String(format: "$%.02f", val)
}
formatMoney(3.1)
formatMoney(3)

//Regular Ball Super Ball
class Ball{
    var type: String
    
    init(type: String = "regular") {
        self.type = type
    }
    
}
let newBall = Ball()
let newBall2 = Ball(type: "cool")

//Beginner - Lost Without a Map
func maps(a : Array<Any>) -> Array<Any> {
    return a.map{$0 as! Int * 2 }
}

maps(a: [1,2,3])

//Grasshopper - Personalized Message
func great(_ name: String, _ owner: String) -> String {
    //    if name.uppercased() == owner.uppercased(){
    //       return "Hello boss"
    //    }else {
    //        return "Hello guest"
    //    }
    return "Hello \(name.uppercased() == owner.uppercased() ? "boss":" guest")"
}

great("Dave", "John")

//SQUARE ROOT OR NOT
func checkSquare(input: [Int]) -> [Int]{
    var array: [Int] = []
    for element in input {
        let isTrueSquare = floor(sqrt(Double(element))) == sqrt(Double(element))
        if isTrueSquare {
            array.append(Int(sqrt(Double(element))))
        }else {
            array.append(element * element)
        }
    }
    return array
}

func chekSquareOneLiner(input: [Int]) -> [Int]{
    return input.map { i in
        let r = sqrt(Double(i))
        return r.truncatingRemainder(dividingBy: 1).isZero ? Int(r) : i * i
    }
}
