//
//  ArcRotationView.swift
//  Splash
//
//  Created by Zhou Hao on 09/08/15.
//  Copyright © 2015年 WOWtv. All rights reserved.
//

import UIKit

@IBDesignable
class ArcRotationView: UIView {

    @IBInspectable var offsetX : CGFloat = 0.0
    @IBInspectable var offsetY : CGFloat = 0.0
    @IBInspectable var radius : CGFloat = 0.0
    
    @IBInspectable var fillColor : UIColor = UIColor.clear
    @IBInspectable var strokeColor : UIColor = UIColor.clear
    @IBInspectable var lineWidth : CGFloat = 0.0
    
    @IBInspectable var startAngle : CGFloat = 0.0
    @IBInspectable var endAngle : CGFloat = 0.0

    func degreeToRadian(_ degree : CGFloat) -> CGFloat {
    
        return degree * CGFloat(M_PI) / 180.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
    
        self.offsetX = 0.0
        self.offsetY = 0.0
        self.radius = 20.0
        
        self.startAngle = 0.0
        self.endAngle = 90.0
        
        self.lineWidth = 1.0
        
        self.fillColor = UIColor.white
        self.strokeColor = UIColor.white
    }
    
    override func prepareForInterfaceBuilder() {

        self.setNeedsDisplay()
    }
    
    override func draw(_ rect : CGRect) {
    
        let context = UIGraphicsGetCurrentContext()
    
        context?.saveGState()
        context?.translateBy(x: self.offsetX, y: self.offsetY)
    
        let arc = CGMutablePath()
    
        arc.addArc(
            center:CGPoint(x:rect.size.width * 0.5,y:rect.size.height * 0.5),
            radius:self.radius,
            startAngle:degreeToRadian(self.startAngle),
            endAngle:degreeToRadian(self.endAngle),
            clockwise:false)
        
        let strokedArc = CGPath(__byStroking: arc, transform: nil,
            lineWidth: self.lineWidth,
            lineCap: .butt,
            lineJoin: .miter,
            miterLimit: 10.0)
    
        context?.addPath(strokedArc!)
        context?.setFillColor(self.fillColor.cgColor)
        context?.setStrokeColor(self.strokeColor.cgColor)
        context?.drawPath(using: .fillStroke)
        context?.restoreGState()
    }
    
}
