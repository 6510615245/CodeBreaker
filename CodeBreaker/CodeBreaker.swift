//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 21/1/2569 BE.
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegChoices: [Peg] = [.red, .green, .yellow, .blue, .brown]
    init() {
        masterCode.randomize(from: pegChoices)
        print(masterCode.pegs)
    }
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    mutating func changeGuessPeg(at index: Int){
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg){
            guess.pegs[index] = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
    
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
        guess.reset()
//        if isOver {
//            
//        }
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guess.pegs[index] = peg
    }
}


