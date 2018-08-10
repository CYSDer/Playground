//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    let shapeLayer = CAShapeLayer()
    let maskLayer = CALayer()

    var circle: UIView!
    var progress: CGFloat = 0
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 557)
        view.backgroundColor = UIColor.white
        
        
        shapeLayer.frame = view.frame
        shapeLayer.path = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: .pi, endAngle: -.pi, clockwise: false).cgPath
        shapeLayer.opacity = 1
        shapeLayer.lineCap = "round"
        shapeLayer.lineWidth = 5
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shapeLayer)
        
        
        let grandientLayer = CAGradientLayer()
        grandientLayer.frame = view.frame
        grandientLayer.colors = [UIColor.red.cgColor, UIColor.cyan.cgColor, UIColor.yellow.cgColor]
        grandientLayer.mask = shapeLayer
        grandientLayer.startPoint = CGPoint(x: 0, y: 0)
        grandientLayer.endPoint = CGPoint(x: 1, y: 0)
        view.layer.addSublayer(grandientLayer)
        
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        
        
        let bgLayer = CALayer()
        bgLayer.opacity = 1
        bgLayer.backgroundColor = UIColor.lightGray.cgColor;
        bgLayer.frame = CGRect(x: 0, y: 500, width: 375, height: 5)
        view.layer.addSublayer(bgLayer)
        
        maskLayer.frame = CGRect(x: 0, y: 500, width: 0, height: 5)
        maskLayer.opacity = 1
        maskLayer.backgroundColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(maskLayer)
        
        
        let lineLayer = CAGradientLayer()
        lineLayer.frame = view.frame
        lineLayer.colors = [UIColor.red.cgColor, UIColor.cyan.cgColor, UIColor.yellow.cgColor]
        lineLayer.mask = maskLayer
        lineLayer.startPoint = CGPoint(x: 0, y: 0)
        lineLayer.endPoint = CGPoint(x: 1, y: 0)
        view.layer.addSublayer(lineLayer)
        
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 130, y: 0, width: 100, height: 40)
        button.setTitle("按钮", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        circle = UIView(frame: CGRect(x: 100, y: 600, width: 30, height: 30))
        circle.backgroundColor = UIColor.cyan
        view.addSubview(circle)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognize:)))
        view.addGestureRecognizer(gesture)
        
        animator = UIViewPropertyAnimator.init(duration: 2, curve: .easeOut, animations: {
           self.circle.frame = self.circle.frame.offsetBy(dx: 200, dy: 0)
        });
    }
    
    @objc func btnClicked(_ button: UIButton) {
        var end = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            end += 0.1
            if end > 1 {
                timer.invalidate()
            }
            
            self.shapeLayer.strokeEnd = CGFloat(end)
            self.maskLayer.frame.size.width = CGFloat(end * 375)
        }
    }
    
    @objc func handlePan(recognize: UIPanGestureRecognizer) {
        switch recognize.state {
        case .began:
            animator.pauseAnimation()
            progress = animator.fractionComplete
        case .changed:
            let translation = recognize.translation(in: self.circle)
            animator.fractionComplete  = translation.x / 200 + progress
        case .ended:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

