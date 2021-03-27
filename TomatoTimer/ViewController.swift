import UIKit

class ViewController: UIViewController {
    // draw a circle
    let shapeLayer = CAShapeLayer()
    let shapeLayer2 = CAShapeLayer()
    let shapeLayer3 = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
         explanation of parameters taken here:
         - clockwise: show the circle clockwise
         - engAngle: 0 starts from the center of right half of circle, and increase clockwise by pi
         */
        let center = CGPoint(x:view.center.x, y: view.center.y-50)
        let circularPath = UIBezierPath(arcCenter: center, radius: self.view.frame.width * 0.4, startAngle: 3 * CGFloat.pi / 2, endAngle: -CGFloat.pi / 2, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.systemOrange.cgColor
        shapeLayer.lineWidth = 10
        
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.strokeEnd = 1 //full stroke
        
        view.layer.addSublayer(shapeLayer)
        
        let center2 = CGPoint(x:view.center.x, y: view.center.y)
        let circularPath2 = UIBezierPath(arcCenter: center2, radius: self.view.frame.width * 0.4, startAngle: 3 * CGFloat.pi / 2, endAngle: -CGFloat.pi / 2, clockwise: false)
        
        shapeLayer2.path = circularPath2.cgPath
        shapeLayer2.strokeColor = UIColor.systemGreen.cgColor
        shapeLayer2.lineWidth = 10
        
        shapeLayer2.lineCap = CAShapeLayerLineCap.round
        shapeLayer2.fillColor = UIColor.clear.cgColor
        
        shapeLayer2.strokeEnd = 1 //full stroke
        
        view.layer.addSublayer(shapeLayer2)
        
        let center3 = CGPoint(x:view.center.x, y: view.center.y+50)
        let circularPath3 = UIBezierPath(arcCenter: center3, radius: self.view.frame.width * 0.4, startAngle: 3 * CGFloat.pi / 2, endAngle: -CGFloat.pi / 2, clockwise: false)
        
        shapeLayer3.path = circularPath3.cgPath
        shapeLayer3.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer3.lineWidth = 10
        
        shapeLayer3.lineCap = CAShapeLayerLineCap.round
        shapeLayer3.fillColor = UIColor.clear.cgColor
        
        shapeLayer3.strokeEnd = 1 //full stroke
        
        view.layer.addSublayer(shapeLayer3)
        
    }
    @IBAction func screenTapped(_ sender: Any) {
        print("attempting to animate stroke")
        
        // basic animation object
        // keypath the variable you want to animate
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 0 //no stroke
        basicAnimation.duration = 2 // set the animation during to 2 seconds
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
    
        
        
        shapeLayer.add(basicAnimation, forKey: "key")
        shapeLayer2.add(basicAnimation, forKey: "key")
        shapeLayer3.add(basicAnimation, forKey: "key")
        
        
    }
    
}

