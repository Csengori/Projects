//: Playground - noun: a place where people can play

import UIKit

class Brain {
    var title: String
    var ingredients: [Ingredients]
    var directions: [Directions]
    
    init(title: String, ingredients: [Ingredients], directions: [Directions]) {
        self.title = title
        self.ingredients = ingredients
        self.directions = directions
    }
}

class Ingredients {
    var mi: String
    var mennyi: Double
    var micsoda: String
    
    required init(mi: String, mennyi: Double, micsoda: String) {
        self.mi = mi
        self.mennyi = mennyi
        self.micsoda = micsoda
    }
}

class Directions{
    var step: Int
    var direction: String
    
   required init(step: Int, direction: String) {
        self.step = step
        self.direction = direction
    }
}

// test scenario

    var colletion: [Brain] = []
    var belevalo: [Ingredients] = []
    var directions: [Directions] = []

func addIngredient(mi: String, mennyi: Double, micsoda: String) {
     let temp = Ingredients(mi: mi, mennyi: mennyi, micsoda: micsoda)
    belevalo.append(temp)
}

func addDirection(stepNum: Int, direction: String) {
    let temp = Directions(step: stepNum, direction: direction)
    directions.append(temp)
}

func addRecipe(ingredient: [Ingredients], directions: [Directions], title: String) {
    let temp = Brain(title: title, ingredients: ingredient, directions: directions)
    colletion.append(temp)
}

let newIngredient = addIngredient(mi: "Kenyer", mennyi: 1.0, micsoda: "gramm")
let newIngredient2 = addIngredient(mi: "Tej", mennyi: 2.0, micsoda: "Kg")
let newIngredient3 = addIngredient(mi: "Vaj", mennyi: 3.0, micsoda: "Tonna")

belevalo

let newDirection = addDirection(stepNum: 1, direction: "KYS")
let newDirection2 = addDirection(stepNum: 2, direction: "SYK")
let newDirection3 = addDirection(stepNum: 3, direction: "Suka")

directions

let newRecipe = addRecipe(ingredient: belevalo, directions: directions, title: "Recept 1 ")
let newRecipe1 = addRecipe(ingredient: belevalo, directions: directions, title: "Recept 2 ")
let newRecipe2 = addRecipe(ingredient: belevalo, directions: directions, title: "Recept 3 ")


collection
