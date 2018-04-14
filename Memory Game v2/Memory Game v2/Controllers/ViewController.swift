//
//  ViewController.swift
//  Memory Game v2
//
//  Created by Liv Souza on 14/04/18.
//  Copyright © 2018 liv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game: MemoryGame!

    var emojiDict = [Int: String]()
    var emojis = ["🐷", "🐯", "🙅🏽‍♀️", "🤙🏾", "🗣", "😾"]
    var playCount = 0
    var score = 0
    
    @IBOutlet var cardButton: [UIButton]!
    
    @IBOutlet weak var playCounter: UILabel!
    @IBOutlet weak var playScore: UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        self.game = MemoryGame(numberOfPairs: (cardButton.count/2))
        self.resetGame()
    }
    
    @IBAction func cardClick(_ sender: UIButton) {
        var position = 0
        for i in cardButton.indices {
            if sender == cardButton[i] {
                position = i
                break
            }
        }
        
        let result = game.chooseCard(at: position)
        updateGameScreen(result: result)
    }
    
    func resetGame(){
        playCount = 0
        score = 0
        
        for index in self.cardButton.indices {
            self.cardButton[index].setTitle("", for: .normal)
            self.cardButton[index].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            self.cardButton[index].isEnabled = true
            self.game.resetGame()
        }
        
        playCounter.text = "\(playCount)"
        playScore.text = "\(score)"
    }
    
    func updateGameScreen (result: Int) {
        var cards = game.cards
        
        for index in cardButton.indices {
            if cards[index].isUp {
                cardButton[index].setTitle(selectEmoji(for: cards[index].identifier), for: .normal)
                cardButton[index].backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                cardButton[index].isEnabled = false
            } else {
                cardButton[index].setTitle("", for: .normal)
                cardButton[index].backgroundColor = cards[index].isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                cardButton[index].isEnabled = cards[index].isMatched ? false : true
            }
        }
       
        playCount += 1
        playCounter.text = "\(playCount)"
        score  += result
        
        
        playScore.text = "\(score)"
        
        if cards.indices.filter({ cards[$0].isMatched }).count == cards.count {
            let alert = UIAlertController(title: "Yay", message: "Game Over!"
                , preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { (action) in
                self.resetGame()
            }))
            
            alert.addAction(UIAlertAction(title: "Exit Game", style: .destructive, handler: { (action) in
                let home = self.storyboard?.instantiateViewController(withIdentifier: "HomeView")
                self.present(home!, animated: true, completion: nil)
            }))
            
            present(alert, animated: true)
        }
    }
    
    func selectEmoji(for id: Int) -> String {
        if emojiDict[id] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
            emojiDict[id] = emojis.remove(at: randomIndex)
        }
        
        return emojiDict[id]!
    }
    
}

