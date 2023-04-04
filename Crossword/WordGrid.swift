//
//  WordGrid.swift
//  Crossword
//
//  Created by csuftitan on 4/4/23.
//

import UIKit

struct Word: Codable {
    var index: String
    var text: String
    var clue: String
    var placement: String
   // var coordinate:
}

class Label {
    var letter: Character = " "
}


class WordSearch {
    var words = [Word]()
    var gridSize = 10
    
    var labels = [[Label]]()
        
    let allLetters = (65...90).map { Character(Unicode.Scalar($0)) }
    
    func makeGrid() {
        labels = (0 ..< gridSize).map { _ in
            (0 ..< gridSize).map { _ in Label() }
        }
        
        fillGaps()
        printGrid()
    }
    
    private func fillGaps() {
        for column in labels {
            for label in column {
                if label.letter == " " {
                    // label.letter = allLetters.randomElement()!
                    label.letter = "*"
                }
            }
        }
    }
    
    func printGrid() {
        for column in labels {
            for row in column {
                print(row.letter, terminator: "")
            }
            
            print("")
        }
    }
}
