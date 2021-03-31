import UIKit

class ClockViewController: UIViewController {
    // draw a circle
    private let clock = CAShapeLayer()
    private let statusLayer1 = CAShapeLayer()
    private let statusLayer2 = CAShapeLayer()
    private let statusLayer3 = CAShapeLayer()
    private let statusLayer4 = CAShapeLayer()
    private let statusLayer5 = CAShapeLayer()
    private let statusLayer6 = CAShapeLayer()
    private let statusLayer7 = CAShapeLayer()
    
    
    private var timerHasStarted = false
    private var secondsRemain = TimeInterval(1) // keep track of remaining time in seconds
    private var timer = DispatchSource.makeTimerSource() // initialize the timer
    private var clockType = 1
    
    private let sessionLength = "120" // seconds
    private let shortBreakLength = "120" // seconds
    private let longBreakLength = "120" // seconds
    
    let timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.center = CGPoint(x:view.center.x, y: view.center.y-50)
        timeLabel.font = UIFont(name: "Helvetica Neue Thin", size: self.view.frame.width * 0.25)
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        
        // starting now, repeat every second
        // timer.activate()
        timer.schedule(deadline: .now(),repeating: 1)
        
        /*
         1, 3, 5, 7 - tomato session
         2, 4, 6 - short break
         8 - long break
         */
        
        // draw the initial timer
        self.drawNewSession(color: UIColor.systemOrange.cgColor, period: sessionLength)
        self.updateStatusBar(currentClockType: 1)
        
        // every second
        timer.setEventHandler { [weak self] in
            if self!.secondsRemain < 0{
                
                self?.secondsRemain = Double(self!.sessionLength)!
                
                DispatchQueue.main.async {
                    self?.clock.removeAllAnimations()
                    self?.clock.removeFromSuperlayer()
                    self?.timerHasStarted = false
                    self?.timer.suspend()
                    
                    self?.clockType += 1
                    
                    if self?.clockType == 9 {
                        self?.clockType -= 8
                    }
                    
                    if self?.clockType == 2 || self?.clockType == 4 || self?.clockType == 6 {
                        self?.drawNewSession(color: UIColor.systemGreen.cgColor, period: self!.shortBreakLength)
                    } else if self?.clockType == 1 || self?.clockType == 3 || self?.clockType == 5 || self?.clockType == 7{
                        self?.drawNewSession(color: UIColor.systemOrange.cgColor, period: self!.sessionLength)
                    } else if self?.clockType == 8 {
                        self?.drawNewSession(color: UIColor.systemBlue.cgColor, period: self!.longBreakLength)
                    }
                    
                    self?.updateStatusBar(currentClockType: self!.clockType)

                    
                    
                }
            }else{
                DispatchQueue.main.async {
                    
                    let timeLabelText = self?.secondsToString(secondsRemain: self!.secondsRemain)
                    self?.timeLabel.text = timeLabelText
                    self?.secondsRemain -= 1
    
                }
            }
        }
    }

    func secondsToString(secondsRemain: TimeInterval) -> String {
        if secondsRemain == 0.0{
            return "00:00"
        }
        
        let minutesRemain = Int(secondsRemain / 60) // take the integer part of the division result
        
        let newSecondsRemain = Int(secondsRemain) - minutesRemain * 60 // update seconds remain
        
        return String(format: "%02d:%02d", minutesRemain, newSecondsRemain)
        
    }
    
    func updateStatusBar(currentClockType: Int){
        
        let centerYAxis = view.center.y + view.frame.height * 0.3
        let offset = CGFloat(0.09) // defines how spread the circles are
        
        // define center index
        let center1 = CGPoint(x: (view.center.x - view.frame.width * offset * 3), y: centerYAxis)
        let center2 = CGPoint(x: (view.center.x - view.frame.width * offset * 2), y: centerYAxis)
        let center3 = CGPoint(x: (view.center.x - view.frame.width * offset), y: centerYAxis)
        let center4 = CGPoint(x: view.center.x, y: centerYAxis)
        let center5 = CGPoint(x: (view.center.x + view.frame.width * offset), y: centerYAxis)
        let center6 = CGPoint(x: (view.center.x + view.frame.width * offset * 2), y: centerYAxis)
        let center7 = CGPoint(x: (view.center.x + view.frame.width * offset * 3), y: centerYAxis)


        
        // define radius
        let shortBreakCircleRadius = CGFloat(view.frame.width * 0.02)
        let sessionCircleRadius = CGFloat(view.frame.width * 0.03)
        
        // define color
        // let defaultColor = UIColor.systemGray.cgColor
        let sessionColor = UIColor.systemOrange.cgColor
        let shortBreakColor = UIColor.systemGreen.cgColor
        // let longBreakColor = UIColor.systemBlue.cgColor
        
        switch currentClockType{
        case 2:
            drawStatusCircle(center: center1, radius: sessionCircleRadius, for: self.statusLayer1, color: sessionColor, withAnimation: true)
        case 3:
            drawStatusCircle(center: center1, radius: sessionCircleRadius, for: self.statusLayer1, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center2, radius: shortBreakCircleRadius, for: self.statusLayer2, color: shortBreakColor, withAnimation: true)
        case 4:
            drawStatusCircle(center: center1, radius: sessionCircleRadius, for: self.statusLayer1, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center2, radius: shortBreakCircleRadius, for: self.statusLayer2, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center3, radius: sessionCircleRadius, for: self.statusLayer3, color: sessionColor, withAnimation: true)
        case 5:
            drawStatusCircle(center: center1, radius: sessionCircleRadius, for: self.statusLayer1, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center2, radius: shortBreakCircleRadius, for: self.statusLayer2, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center3, radius: sessionCircleRadius, for: self.statusLayer3, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center4, radius: shortBreakCircleRadius, for: self.statusLayer4, color: shortBreakColor, withAnimation: true)
        case 6:
            drawStatusCircle(center: center1, radius: sessionCircleRadius, for: self.statusLayer1, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center2, radius: shortBreakCircleRadius, for: self.statusLayer2, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center3, radius: sessionCircleRadius, for: self.statusLayer3, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center4, radius: shortBreakCircleRadius, for: self.statusLayer4, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center5, radius: sessionCircleRadius, for: self.statusLayer5, color: sessionColor, withAnimation: true)
        case 7:
            drawStatusCircle(center: center1, radius: sessionCircleRadius, for: self.statusLayer1, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center2, radius: shortBreakCircleRadius, for: self.statusLayer2, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center3, radius: sessionCircleRadius, for: self.statusLayer3, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center4, radius: shortBreakCircleRadius, for: self.statusLayer4, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center5, radius: sessionCircleRadius, for: self.statusLayer5, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center6, radius: shortBreakCircleRadius, for: self.statusLayer6, color: shortBreakColor, withAnimation: true)
        case 8:
            drawStatusCircle(center: center1, radius: sessionCircleRadius, for: self.statusLayer1, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center2, radius: shortBreakCircleRadius, for: self.statusLayer2, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center3, radius: sessionCircleRadius, for: self.statusLayer3, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center4, radius: shortBreakCircleRadius, for: self.statusLayer4, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center5, radius: sessionCircleRadius, for: self.statusLayer5, color: sessionColor, withAnimation: false)
            drawStatusCircle(center: center6, radius: shortBreakCircleRadius, for: self.statusLayer6, color: shortBreakColor, withAnimation: false)
            drawStatusCircle(center: center7, radius: sessionCircleRadius, for: self.statusLayer7, color: sessionColor, withAnimation: true)
            
        default:
            print("default")
        }
    }
    
    func drawStatusCircle(center: CGPoint, radius: CGFloat, for layer: CAShapeLayer, color: CGColor, withAnimation: Bool){
        
        let center = center
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        // create circle
        layer.path = circularPath.cgPath
        layer.lineWidth = 2
        layer.strokeColor = color
        layer.lineCap = CAShapeLayerLineCap.round
        
        if withAnimation {
            layer.strokeEnd = 0 // empty at beginning
        } else {
            layer.strokeEnd = 0
        }
        
        if withAnimation {
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            
            
            basicAnimation.toValue = 1 //no stroke
            basicAnimation.duration = 1
            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
            basicAnimation.isRemovedOnCompletion = false
            
            layer.add(basicAnimation, forKey: "key")
        }
        
        view.layer.addSublayer(layer)
        
        
        
    }
    
    func drawNewSession(color: CGColor, period: String){
        
        secondsRemain = Double(period)!
        
        /*
         explanation of parameters taken here:
         - clockwise: show the circle clockwise
         - engAngle: 0 starts from the center of right half of circle, and increase clockwise by pi
         */
        let center = CGPoint(x:view.center.x, y: view.center.y-50)
        let circularPath = UIBezierPath(arcCenter: center, radius: self.view.frame.width * 0.4, startAngle: 3 * CGFloat.pi / 2, endAngle: -CGFloat.pi / 2, clockwise: false)
        
        // create circle
        clock.path = circularPath.cgPath
        clock.strokeColor = color
        clock.lineWidth = 10
        clock.lineCap = CAShapeLayerLineCap.round
        clock.fillColor = UIColor.clear.cgColor
        clock.strokeEnd = 1 //full stroke
        
        // create time label
        
        timeLabel.text = secondsToString(secondsRemain: TimeInterval(period)!)
        
        view.layer.addSublayer(clock)
        view.addSubview(timeLabel)
        
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        
        if !timerHasStarted{
            // basic animation object
            // keypath the variable you want to animate
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            
            
            basicAnimation.toValue = 0 //no stroke
            basicAnimation.duration = secondsRemain
            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
            basicAnimation.isRemovedOnCompletion = false
            
            clock.add(basicAnimation, forKey: "key")

            timer.resume()
            timerHasStarted = true
        }
        
        
        
        
    }
    
}

