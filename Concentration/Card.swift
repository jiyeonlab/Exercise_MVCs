//
//  Card.swift
//  Concentration
//
//  Created by JiyeonKim on 28/08/2019.
//  Copyright © 2019 JiYeonKim. All rights reserved.
//


// Model에 해당하는 코드

import Foundation

// 카드는 클래스가 아닌 구조체로 만들었다.
// 게임에 필요한 카드를 만들어내는 곳.
struct Card: Hashable {
    
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    // static이 붙으면, 이 구조체를 통해 만들어지는 카드 개개인에게는 이 변수가 없고
    // 카드 타입 자체에 저장되는 변수이다.
    private static var identifierFactor = 0
    
    // 카드가 스스로 식별자를 만들어내기 위한 함수.(게임에서는 식별자를 신경쓰지 않도록)
    // Card는 이 메시지를 이해하지 못한다. Card "타입"만 이해할 수 있음. 즉, 타입에 붙어있는 함수.
    private static func getUniqueIdentifier() -> Int {
        
        // static 메소드 안 이기 때문에, Card.identifierFactor로 안해도, 정적 변수에 접근할 수 있다.
        identifierFactor += 1
        return identifierFactor
    }
    
    init(){
        
        // type method는 타입에 붙어있는 함수이므로, 타입 자체에게 함수를 요청해야함.
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
