//
//  ViewController.swift
//  TwitterLoginDemo
//
//  Created by Cynthia Maxwell on 10/6/20.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var birdyView: UIImageView!
    var birdyCenter  = CGPoint()
    
    @IBAction func didPanBirdy(_ sender: UIPanGestureRecognizer) {
        // Get the current translation value from the gesture recognizer
        
        if (sender.state == .ended){
            print("ended")
            
            let duration: TimeInterval = 3.0
            let dampingRatio: CGFloat = 0.25
            let delay: TimeInterval = 0.0
                        
            UIView.animate(withDuration: duration,
                           delay: delay,
                           usingSpringWithDamping: dampingRatio,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: { [self] in
                            birdyView.center = birdyCenter
            }, completion: nil)
        }
        
        let translation = sender.translation(in: view)
        
        // Update the bird's position by adding and assigning the translation
        // from the gesture recognizer
        birdyView.center.x += translation.x
        birdyView.center.y += translation.y
        // reset the gesture recognizer's scale in preperation for the next call
        sender.setTranslation(CGPoint(x: 0, y: 0), in: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        birdyCenter = birdyView.center
        
        makeBirdFly()
    }
    
    
    func shakeTheBird(){
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 20
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: birdyView.center.x - 10, y: birdyView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: birdyView.center.x + 10, y: birdyView.center.y))

        birdyView.layer.add(animation, forKey: "position")
        
    }
    
    func makeBirdFly(){
                
        // do a keyframe animation on the bird
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 16,y: 239))
        path.addCurve(to: CGPoint(x: 301, y: 239), controlPoint1: CGPoint(x: 136, y: 373), controlPoint2: CGPoint(x: 178, y: 110))

        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")

        // set the animations path to our bezier curve
        anim.path = path.cgPath

        // set some more parameters for the animation
        // this rotation mode means that our object will rotate so that it's parallel to whatever point it is currently on the curve
        anim.rotationMode = CAAnimationRotationMode.rotateAuto
        anim.repeatCount = Float.infinity
        anim.autoreverses = true
        anim.duration = 5.0

        // we add the animation to the squares 'layer' property
        birdyView.layer.add(anim, forKey: "animate position along path")
    }


}

