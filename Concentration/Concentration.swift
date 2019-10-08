//
//  Concentration.swift
//  Concentration
//
//  Created by JiyeonKim on 28/08/2019.
//  Copyright © 2019 JiYeonKim. All rights reserved.
//

// Model에 해당하는 코드

import Foundation

// class에서는 모든 변수들이 초기화되고 나면, 인수가 없는 init을 자동으로 가지게 된다.
// class였는데, struct로 바꾸었음.
struct Concentration
{
    // 카드 묶음에 대한 데이터를 포함하고 있는 배열
    // 맨 뒤에 ()을 붙여서, argument가 하나도 없는 init을 가지고 있음. 즉, 아무것도 없는 배열을 만든 것.
    // 구조체와 작동할 수 있는 Card 배열임.
    private(set) var cards = [Card]()
    
    // 앞면인 카드가 한장인지 확인하는 변수
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
//            var foundIndex: Int?
//
//            // cards 배열을 돌면서, isFaceUp = true인 애의 index를 foundindex에 넣음.
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }else {
//                        return nil
//                    }
//                }
//            }
//
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // 카드가 선택되면, concentration 모델이 알아야 해서 필요.
    // 카드가 선택되면 controller가 알기 때문에, controller가 여기로 알려줌.
    // 구조체 내의 인스턴스 함수에서 프로퍼티를 수정하려면, mutating이라는 키워드를 붙여줘야함.
    mutating func chooseCard(at index: Int){
        
        // index에 없는 수를 넣으면, 오류를 발생시키고 에러문을 내보냄.
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : chosen index not in the cards")
        
        // 앞면인 카드가 하나일 때.
        if !cards[index].isMatched {
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                
                // check if cards match
                // card 구조체에서 hashable을 썼기 때문에, 이렇게 '=='으로 바로 비교 가능.
                if cards[matchIndex] == cards[index] {
                    print("card Matching!!")
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                //indexOfOneAndOnlyFaceUpCard = nil     // computed prop erty에서 수행하는 내용이라 주석.
                
            }else{
                
                //print("either no cards or 2 cards are face up.")
                
                /* 여기도 computed property에서 수행하는 내용이라 주석.
                // either no cards or 2 cards are face up. 앞면인 카드가 없거나, 앞면인 카드가 2장일 때.
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                 */
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // numberOfPairsOfCards 는 게임을 하기 위해 카드가 총 몇 쌍인지 알아야 하니까.
    // numberOfPairsOfCards 수만큼 Card 배열에 넣어줘야함.
    init(numberOfPairsOfCards:Int){
        
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one paif of cards")
        
        var unshuffleCards = [Card]()
        
        for _ in 0..<numberOfPairsOfCards{
            
            // let card = Card(identifier: identifier) 카드의 식별자를 게임이 아닌 카드가 직접 설정하도록 해야함.
            let card = Card()   // 카드 구조체에서 가져온 것.
            //cards += [card, card]   // 카드 구조체에서 만든 카드를 cards라는 배열에 넣어줌.
            unshuffleCards += [card, card]
            
        }
        
        // TODO: Shuffle the cards
        for _ in 0..<unshuffleCards.count {
            let rand = Int(arc4random_uniform(UInt32(unshuffleCards.count)))
            cards.append(unshuffleCards[rand])
            unshuffleCards.remove(at: rand)
            
            // 간단하게 하는 방법..
            //cards.swapAt(0, rand)
        }
        
    }
    
}

extension Collection {
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
}
