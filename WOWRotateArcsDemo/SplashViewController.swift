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
    
    override func viewWillAppear(_ animated : Bool) {
        super.viewWillAppear(animated)
        
        setupImpulseViewAnimation(impulseView)
        setupImpulseViewAnimation(impulseView2)
        setupArcsRoationAnimations()
        
    }
    
    // #Mark : loading animation
    func setupImpulseViewAnimation(_ impluse : ArcRotationView) {
        
        impluse.alpha = 0.0
        impluse.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: { () -> Void in
            
            impluse.alpha = 1.0
            impluse.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            }) { (finished) -> Void in
                
                UIView.animate(withDuration: 0.7, animations: { () -> Void in
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: { () -> Void in
                        
                        impluse.alpha = 0.0
                        impluse.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        
                        }, completion: { (finished) -> Void in
                            
                            self.setupImpulseViewAnimation(impluse)
                    })
                }) 
        }
        
    }

    func setupArcsRoationAnimations() {
        
        for i in 0 ..< self.arcViews.count {
            
            let v = self.arcViews[i]
            
            let anim = generateLayerAnimationWithDuration(CGFloat(arc4random() % 5) + kADVMinimumAnimationDuration,reverse: ((i == 3 || i == 5)))
            
            v.layer.add(anim, forKey: kADVAnimationKey)
        }
    }
    
    
    func generateLayerAnimationWithDuration(_ duration : CGFloat, reverse : Bool) -> CAKeyframeAnimation {
        
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        
        let rotationValues = reverse ? [2.0 * CGFloat(M_PI), 0.0] : [0.0, 2.0 * CGFloat(M_PI)]
        rotationAnimation.values = rotationValues
        
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.duration = CFTimeInterval(duration)
        
        return rotationAnimation
    }
    
    func stopAll() {
        
        removeAllAnimations()
        
        self.impulseView.isHidden = true
        self.impulseView2.isHidden = true
        
        for i in 0 ..< self.arcViews.count {
            
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
