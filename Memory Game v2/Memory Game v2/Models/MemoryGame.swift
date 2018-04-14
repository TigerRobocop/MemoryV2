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
        
        cards.shuffle(count: cards.count)
        
    }
    
    func chooseCard (at index: Int) -> Int {
        let cardsUp = cards.indices.filter({ cards[$0].isUp })
        let currentUpCardIndex = cardsUp.count == 1 ? cardsUp.first : nil
        
        var result: Int  = 0
        
        if !cards[index].isMatched {
            if let matchIndex = currentUpCardIndex {
                if matchIndex != index && cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    result = 2
                } else {
                     result = -1
                }
                
                cards[index].isUp = true
            } else {
                for i in cards.indices {
                    cards[i].isUp = (i == index)
                }
            }
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

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle(count: Int)
    {
        for _ in 0..<count
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
