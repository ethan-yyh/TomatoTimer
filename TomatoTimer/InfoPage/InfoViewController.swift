//
//  InfoViewController.swift
//  TomatoTimer
//
//  Created by Ziyao Wang on 2021-04-02.
//

import UIKit
import WebKit

class InfoViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    //var webView: WKWebView = WKWebView()
    //@IBOutlet weak var webView: WKWebView!
    var footerView: UIView = UIView()
    
    var leftArrowButton = UIButton(type: UIButton.ButtonType.custom)
    var rightArrowButton = UIButton(type: UIButton.ButtonType.custom)
    var listArrowButton = UIButton(type: UIButton.ButtonType.custom)
    
    let kHEADERHEIGHT: CGFloat = 0.0
    let kFOOTERHEIGHT: CGFloat = 44.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(self.webView)
        webView.allowsBackForwardNavigationGestures=true
        webView.navigationDelegate=self
        webView.load(URLRequest(url: NSURL(string:"https://en.wikipedia.org/wiki/Pomodoro_Technique#:~:text=The%20Pomodoro%20Technique%20is%20a,length%2C%20separated%20by%20short%20breaks.")! as URL))
    }
    
    override func viewWillLayoutSubviews() {
        //let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        webView.frame = CGRect(
            origin: CGPoint(x:0, y:statusBarHeight+kHEADERHEIGHT),
            size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - (statusBarHeight + kHEADERHEIGHT)-kFOOTERHEIGHT))
        footerView.frame = CGRect(origin:CGPoint( x: 0,y: self.view.frame.size.height-kFOOTERHEIGHT), size: CGSize(width: self.view.frame.size.width, height: kFOOTERHEIGHT))
        leftArrowButton.frame = CGRect(origin:CGPoint( x: 5,y: self.view.frame.size.height-kFOOTERHEIGHT), size: CGSize(width: kFOOTERHEIGHT, height: kFOOTERHEIGHT))
    }
    
    


}

