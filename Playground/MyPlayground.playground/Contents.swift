//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person {
    var firstName: String
    var lastName: String
    var age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

extension Person : AgeScenario  {
    func fullName() -> String {
        return firstName + " " + lastName
    }
    
    func ageCategory() -> String {
        switch age {
        case 0...5:
            return "Under 5"
        case 6...10:
            return "Over 5"
        default:
            return "Over 11"
        }
    }
}

protocol AgeScenario {
    var age: Int { get }
    func ageCategory() -> String
}

let testCase = Person(firstName: "Fname", lastName: "Lname", age: 14)

testCase.fullName()

testCase.ageCategory()


