func calculateScore(_ input: String) -> Int {
    // The score
    var score = 0
    var count = 0
    var apperanceCount = [Character: Int]()
    
    // TODO: Implement your logic here
    for letter in letters {
        if input.uppercased().contains(letter.key){
            apperanceCount = [letter.key: count + 1]
            for apperance in apperanceCount {
                print("lol \(apperance)")
                if apperance.value == 1 {
                    score += letter.value
                } else if apperance.value == 2 {
                   score += letter.value / 2
                } else if apperance.value > 2 {
                    score += letter.value * 2
                }
            }
        }
    }
    return score
}

var letters = [Character: Int]()
letters["A"] = 1
letters["B"] = 3
letters["C"] = 3
letters["D"] = 2
letters["E"] = 1
letters["F"] = 4
letters["G"] = 2
letters["H"] = 4
letters["I"] = 1
letters["J"] = 8
letters["K"] = 5
letters["L"] = 1
letters["M"] = 3
letters["N"] = 1
letters["O"] = 1
letters["P"] = 3
letters["Q"] = 10
letters["R"] = 1
letters["S"] = 1
letters["T"] = 1
letters["U"] = 1
letters["V"] = 4
letters["W"] = 4
letters["X"] = 8
letters["Y"] = 4
letters["Z"] = 10

let score = calculateScore("Thomas")

print("score for name Thomas is \(score)")
