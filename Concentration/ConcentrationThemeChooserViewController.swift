//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by JiyeonKim on 08/10/2019.
//  Copyright © 2019 JiYeonKim. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    // theme 딕셔너리는 Button에 있는 title을 이름으로 가짐.
    let themes = [
        "Sports": "⚽️🥎🎱🏓🏑⛳️🏹🏉🏐🏈",
        "Faces": "😀🥰😇🤩😎🤬🤯☹️🥶🤮",
        "Animals": "🐱🐸🐯🐵🐥🐺🐝🐨🐶🦉"
    ]
    
    // 새로운  MVC를 준비하는 함수.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            
            // 버튼의 title에 해당하는 theme을 할당.
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }

}
