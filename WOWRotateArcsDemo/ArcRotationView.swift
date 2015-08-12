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
    
    @IBInspectable var fillColor : UIColor = UIColor.clearColor()
    @IBInspectable var strokeColor : UIColor = UIColor.clearColor()
    @IBInspectable var lineWidth : CGFloat = 0.0
    
    @IBInspectable var startAngle : CGFloat = 0.0
    @IBInspectable var endAngle : CGFloat = 0.0

    func degreeToRadian(degree : CGFloat) -> CGFloat {
    
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
        
        self.fillColor = UIColor.whiteColor()
        self.strokeColor = UIColor.whiteColor()
    }
    
    override func prepareForInterfaceBuilder() {

        self.setNeedsDisplay()
    }
    
    override func drawRect(rect : CGRect) {
    
        let context = UIGraphicsGetCurrentContext()
    
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, self.offsetX, self.offsetY)
    
        let arc = CGPathCreateMutable()
    
        CGPathAddArc(arc, nil,
            rect.size.width * 0.5, rect.size.height * 0.5,
            self.radius,
            degreeToRadian(self.startAngle),
            degreeToRadian(self.endAngle),
            true)
    
        let strokedArc = CGPathCreateCopyByStrokingPath(arc, nil,
            self.lineWidth,
            .Butt,
            .Miter,
            10.0)
    
        CGContextAddPath(context, strokedArc)
        CGContextSetFillColorWithColor(context, self.fillColor.CGColor)
        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor)
        CGContextDrawPath(context, .FillStroke)
        CGContextRestoreGState(context)
    }
    
}
