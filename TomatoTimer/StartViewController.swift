//
//  StartViewController.swift
//  TomatoTimer
//
//  Created by Ziyao Wang on 2021-04-04.
//

import UIKit

class StartViewController: UIViewController {

    var images:[String] = ["S1.jpeg","S2.jpeg","S3.jpeg"]
    var timer = Timer()
    var photoCount:Int = 0
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
            super.viewDidLoad()
            
        
        imageView.image = UIImage.init(named: "S3.jpeg")
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: "onTransition", userInfo: nil, repeats: true)
        }
        
    @IBAction func startButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "ClockView")
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
                show(vc, sender: self)
    }
    @IBAction func unwindToStartViewController(_ unwindSegue: UIStoryboardSegue) {}
    @objc func onTransition() {
        if (photoCount < images.count - 1){
            photoCount = photoCount  + 1;
        }else{
            photoCount = 0;
        }
       // print(photoCount)
        UIView.transition(with: self.imageView, duration: 1.5, options: .transitionCrossDissolve, animations: { [self] in
            self.imageView.image = UIImage(named: self.images[photoCount])
            print(self.images[photoCount])
            
        }, completion: nil)
    }
}
