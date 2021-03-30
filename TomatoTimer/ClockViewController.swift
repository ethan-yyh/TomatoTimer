import UIKit

class ClockViewController: UIViewController {
    // draw a circle
    let shapeLayer = CAShapeLayer()
    var time = TimeInterval(0) // keep track of remaining time in seconds
    var timer = DispatchSource.makeTimerSource() // initialize the timer
    
    let timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sessionLength = "5" // seconds
        // let shortBreakLength = 5 // seconds
        // let longBreakLength = 5 // seconds
        
        timeLabel.center = CGPoint(x:view.center.x, y: view.center.y-50)
        timeLabel.font = UIFont(name: "Helvetica Neue Thin", size: self.view.frame.width * 0.25)
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        
        /*
         1, 3, 5, 7 - tomato session
         2, 4, 6 - short break
         8 - long break
         */
        
        drawNewSession(color: UIColor.systemOrange.cgColor, period: sessionLength)
        time = Double(sessionLength)!
        
        // starting now, repeat every second
        timer.schedule(deadline: .now(),repeating: 1)
        
        // every second
        timer.setEventHandler {
            print(self.time)
            if self.time<0{
                self.timer.cancel()
                self.time = Double(sessionLength)!
                DispatchQueue.main.async {
                    self.drawNewSession(color: UIColor.systemOrange.cgColor, period: sessionLength)
                }
            }else{
                DispatchQueue.main.async {
                    
                    self.timeLabel.text = String(self.time)
                    self.time -= 1
    
                }
            }
        }
    
        
        
        
        
        
        
    }
    func drawNewSession(color: CGColor, period: String){
        
        /*
         explanation of parameters taken here:
         - clockwise: show the circle clockwise
         - engAngle: 0 starts from the center of right half of circle, and increase clockwise by pi
         */
        let center = CGPoint(x:view.center.x, y: view.center.y-50)
        let circularPath = UIBezierPath(arcCenter: center, radius: self.view.frame.width * 0.4, startAngle: 3 * CGFloat.pi / 2, endAngle: -CGFloat.pi / 2, clockwise: false)
        
        // create circle
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 7
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1 //full stroke
        
        // create time label
        
        timeLabel.text = period
        
        
        view.layer.addSublayer(shapeLayer)
        view.addSubview(timeLabel)
        
    }
    @IBAction func screenTapped(_ sender: Any) {
        
        // basic animation object
        // keypath the variable you want to animate
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        
        basicAnimation.toValue = 0 //no stroke
        basicAnimation.duration = time
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "key")
        
        timer.resume()
        
        
        
        
    }
    
}

