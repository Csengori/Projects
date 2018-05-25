//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//Don't give me five!
func dontGiveMeFive(_ start: Int, _ end: Int) -> Int {
    //let filter:[Int] = (start...end).filter{$0 % 5 == 0 && $0 % 2 != 0}
//    let filteredArray = Set(start...end).subtracting(filter)
//
//    print(filter)
//    print(filteredArray.sorted())
    
    return Set(start...end).subtracting((start...end).filter{$0 % 5 == 0 && $0 % 2 != 0}).count
}

dontGiveMeFive(4, 17)
