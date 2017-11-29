/**
 According to the rules, finds the closest number to zero
 
 - returns:
 the closest number to zero as per the rules
 
 - parameters:
 - input: an array of integer numbers to work on
 */

func closestToZero(_ input: [Int]) -> Int {
    var negativeMax = input.min()!
    var positiveMin = input.max()!
    var element = 0
   
    for item in input {
        if item > negativeMax && item != 0 && item < 0 {
            negativeMax = item
            print(item)
        } else if item < positiveMin && item != 0 && item > 0 {
            positiveMin = item
        }
    }

    if negativeMax != 0 && negativeMax != positiveMin {
        element = negativeMax
    } else if positiveMin == negativeMax || negativeMax == 0  && positiveMin != 0{
       element = positiveMin
    }
 
    return element
}

print("Closest to Zero")
print("")

print("Problem:")
print("Given an array of integers, find the one closest to zero, not including zero itself.")
print("If a positive and negative number tie, the positive number should be returned.")
print("")

print("Example:")
print("Input: [4, 3, -10, 4, 3, 0, -2, -5, 8]")
print("Output: -2")
print("")

print("Tests:")

let testArray = [ 4, 3, -10, 4, 3, 0, -2, -5, 8 ]
print("Your output: \(closestToZero(testArray))")
print("")
