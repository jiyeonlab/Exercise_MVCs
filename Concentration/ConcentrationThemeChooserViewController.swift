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
    
    // 코드에서 segue를 만들기 위한 action 추가.
    // Sports, Faces, Animals 전부 여기로 연결됨.
    @IBAction func changeTheme(_ sender: Any) {
        
        // MARK: 조건부 performSegue 실행하기.
        // SplitView에 있을 때, detail을 찾았다면 if를 실행하고, 그렇지 않다면 else를 실행한다.
        
        // splitView의 detail이 있다면, 게임을 reset하지 않고, 그 상태에서 카드의 theme만 바꿔줌.
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        }
        // iPhone에서도 같은 일을 하기 위해 추가.
        else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        // splitView의 detail을 못찾으면, segue를 새로 만들어 줌.
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    // ConcentrationViewController로 splitViewController를 찾아내자.
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // changeTheme()에서 splitView의 detail을 찾는 건, iPad나 iPhone Plus에서만 가능함.
    // iPhone에서도 같은 일을 하게 하려면, MVC를 포인터로 잡고 있다가 다음에 필요로 하는 사람에게 이 포인터를 넘겨주면 됨.
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    // 새로운  MVC를 준비하는 함수.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare function")
        if segue.identifier == "Choose Theme" {
            
            // 버튼의 title에 해당하는 theme을 할당.
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }

}
