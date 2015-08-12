//
//  SplashViewController.swift
//  WOWRotateArcsDemo
//
//  Created by Zhou Hao on 3/8/15.
//  Copyright © 2015 WOWtv. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: constants
    let kADVAnimationKey                        = "rotationAnimation"
    let kADVImpulseAnimationGroupKey            = "impulseAnimationGroup"
    let kADVMinimumAnimationDuration : CGFloat  = 2.0
    let kADVDefaultAnimationDuration : CGFloat  = 0.3
    
    @IBOutlet weak var impulseView: ArcRotationView!
    @IBOutlet weak var impulseView2: ArcRotationView!
    @IBOutlet var arcViews: [ArcRotationView]!    
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        
        setupImpulseViewAnimation(impulseView)
        setupImpulseViewAnimation(impulseView2)
        setupArcsRoationAnimations()
        
    }
    
    // #Mark : loading animation
    func setupImpulseViewAnimation(impluse : ArcRotationView) {
        
        impluse.alpha = 0.0
        impluse.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        
        UIView.animateWithDuration(0.7, delay: 0, options: .CurveLinear, animations: { () -> Void in
            
            impluse.alpha = 1.0
            impluse.transform = CGAffineTransformMakeScale(0.8, 0.8)
            
            }) { (finished) -> Void in
                
                UIView.animateWithDuration(0.7) { () -> Void in
                    
                    UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: { () -> Void in
                        
                        impluse.alpha = 0.0
                        impluse.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        
                        }, completion: { (finished) -> Void in
                            
                            self.setupImpulseViewAnimation(impluse)
                    })
                }
        }
        
    }

    func setupArcsRoationAnimations() {
        
        for var i = 0; i < self.arcViews.count; i++ {
            
            let v = self.arcViews[i]
            
            let anim = generateLayerAnimationWithDuration(CGFloat(arc4random() % 5) + kADVMinimumAnimationDuration,reverse: ((i == 3 || i == 5)))
            
            v.layer.addAnimation(anim, forKey: kADVAnimationKey)
        }
    }
    
    
    func generateLayerAnimationWithDuration(duration : CGFloat, reverse : Bool) -> CAKeyframeAnimation {
        
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        
        let rotationValues = reverse ? [2.0 * CGFloat(M_PI), 0.0] : [0.0, 2.0 * CGFloat(M_PI)]
        rotationAnimation.values = rotationValues
        
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.removedOnCompletion = false
        rotationAnimation.duration = CFTimeInterval(duration)
        
        return rotationAnimation
    }
    
    func stopAll() {
        
        removeAllAnimations()
        
        self.impulseView.hidden = true
        self.impulseView2.hidden = true
        
        for var i = 0; i < self.arcViews.count; i++ {
            
            let v = self.arcViews[i]
            v.layer.removeAllAnimations()
            
            v.startAngle = 0
            v.endAngle = 360
            
            v.setNeedsDisplay()
        }
        
    }
    
    func removeAllAnimations() {
        
        self.view.layer.removeAllAnimations()
    }
    
}
