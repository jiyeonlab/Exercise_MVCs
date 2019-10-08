//
//  ViewController.swift
//  Concentration
//
//  Created by JiyeonKim on 27/08/2019.
//  Copyright © 2019 JiYeonKim. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // controller에서 model로 큰 초록색 화살표(MVC모델)를 만들기 위함.
    // 클래스는 모든 변수가 초기화되면, 인수가 없는 init을 자동으로 가지기 때문에 = Concentration() 으로 초기화 가능.
    // game 을 초기화 중인데, cardButtons라는 애도 써야함. 근데 cardButtons는 아직 초기화가 안된 상태이다.
    // -> 따라서 lazy 를 써줘서, 사용하기 전까지는 초기화가 되지 않도록 함. 누군가 game을 사용하려 할 때, 초기화를 함.
    // lazy 쓰면, didSet은 못씀.
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // private(set) 을 써도 되는데, 이미 get 속성만 있기 때문에 private만 썼음.
    private var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    private var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
        //flipCountLabel.text = "Flips: \(flipCount)"
        
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel() 
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🦇😱🙀👿🎃👻🍭🍬🍎"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        
        // 요청할 때만 dictionary에 주고 싶어서.
        if emoji[card] == nil, emojiChoices.count > 0  {
            
            /*
             let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
             emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
             */
        
            //emojiChoices를 문자열로 바꿔줬기 때문에.
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            
        }
        
        return emoji[card] ?? "?"
    }
    
    // MARK : Handle Card Touch Behavior
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            
            // 이제 컨트롤러에서 flipCard를 하는 것이 아니라, 모델에게 이 카드를 선택하라고 알려줌.
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else {
            print("chosen card was not in cardbuttons")
        }
    }
    
    // 카드가 선택되면 게임이 변화하는데, view와 model 사이의 동기화를 해주는 것.
    // 모든 카드들을 살펴보고, 모든 cardButtons들의 짝이 맞았는지를 확인함. ex. 앞면인지.. 짝이 맞았는지.. 등
    private func updateViewFromModel() {
        if cardButtons != nil {
             for index in cardButtons.indices {
                
                // button과 card가 매칭되도록 한 것. (view와 model 간의 동기화를 위해)
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.468845427, blue: 1, alpha: 1)
                    
                    
                }
            }
        }
    }
}

// extension 사용
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
        
    }
}

