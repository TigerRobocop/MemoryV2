//
//  MemoryGame.swift
//  Memory Game v2
//
//  Created by Liv Souza on 14/04/18.
//  Copyright © 2018 liv. All rights reserved.
//

import Foundation

class MemoryGame {
    
    var cards = [Card]()
    
    init (numberOfPairs: Int) {
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
    }
    
    func chooseCard (at index: Int) -> String {
        let cardsUp = cards.indices.filter({ cards[$0].isUp })
        let currentUpCardIndex = cardsUp.count == 1 ? cardsUp.first : nil
        
        var result: String = "";
        
        if !cards[index].isMatched {
            if let matchIndex = currentUpCardIndex {
                if matchIndex != index && cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    result = "match"
                }
                
                cards[index].isUp = true
            } else {
                for i in cards.indices {
                    cards[i].isUp = (i == index)
                }
                
                result = "unmatch"
            }
        } else {
          result = "none"
        }
        
        return result
    }
    
    func resetGame () {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isUp = false
        }
    }
    
   
    
}
