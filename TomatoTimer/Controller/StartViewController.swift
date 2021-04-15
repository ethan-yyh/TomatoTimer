//
//  StartViewController.swift
//  TomatoTimer
//
//  Created by Yiheng Yao on 2021-04-04.
//

import UIKit

class StartViewController: UIViewController {
    //=====================================================================================================
    // welcome texts
    let welcomeTexts: [String] = ["Live", "Learn", "Play"]
    var currentTextIndex: Int = 0
    
    var timer = Timer()
    let welcomeTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))

    //=====================================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating welcome text label
        
        welcomeTextLabel.center = CGPoint(x:view.center.x, y: view.center.y-50)
        welcomeTextLabel.font = UIFont(name: "Helvetica Neue Thin", size: self.view.frame.width * 0.20)
        welcomeTextLabel.textColor = .white
        welcomeTextLabel.textAlignment = .center
        view.addSubview(welcomeTextLabel)
        
        // initialize the text to the first welcome text
        welcomeTextLabel.text = welcomeTexts[currentTextIndex]
        currentTextIndex += 1
        
        // a timer that files an action every two seconds
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.nextWelcomeText), userInfo: nil, repeats: true)
        
    }
        
    //=====================================================================================================
    @objc func nextWelcomeText() {
        if currentTextIndex <= 2 {
            
            // change word for welcome text label
            UIView.transition(with: self.welcomeTextLabel, duration: 1, options: .transitionCrossDissolve, animations: { [weak self] in
                self?.welcomeTextLabel.text = self?.welcomeTexts[self!.currentTextIndex]
            }, completion: nil)
            
            // increment current text index
            currentTextIndex += 1
        } else if currentTextIndex > 2 {
            
            // stop the timer
            self.timer.invalidate()
            
            // go to clock view
            print("transferring to clock view")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let clockViewController = storyboard.instantiateViewController(identifier: "ClockView")
            clockViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(clockViewController, animated: true, completion: nil)
            show(clockViewController, sender: self)
        }
    }
}
