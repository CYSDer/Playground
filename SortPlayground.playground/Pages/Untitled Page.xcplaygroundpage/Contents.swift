//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var totalSteps: Int = 0 {
    willSet(newTotalSteps) {
        print("About to set totalSteps to \(newTotalSteps)")
    }
    didSet {
        if totalSteps > oldValue  {
            print("Added \(totalSteps - oldValue) steps")
        }
    }
}

let optionalString: String? = nil ?? "def"
optionalString

let precomposed: Character = "\u{D55C}"
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"

let preStr = String(precomposed)
let decStr = String(decomposed)
preStr.count
decStr.count
preStr.endIndex

enum People: String {
    case man, woman
}

People.init(rawValue: "man")

struct FirstValue: Equatable {
    var x = 1
    var y = 2
}

let first = FirstValue()
let second = first

if first == second {
    print("so ga")
}

struct InitTest {
    let a: Int?
    var b: Int = 2
    var desC: String?
    
    mutating func changeing() {
//        self.a = nil
        self.desC = nil
    }
}



struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

