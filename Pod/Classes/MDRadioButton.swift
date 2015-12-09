//
//  MDRadioButton.swift
//  stackoverflow
//
//  Created by Aleph Retamal on 12/4/15.
//  Copyright © 2015 stackoverflow. All rights reserved.
//

import UIKit

@IBDesignable
class MDRadioButton: UIButton {

    @IBInspectable var on:Bool = true {
        didSet {
            updateColors()
        }
    }
    var outterCircle:CAShapeLayer?
    var innerCircle:CAShapeLayer?
    var bigCircle:CAShapeLayer?
    
    @IBInspectable var activeColor:UIColor = UIColor.redColor() {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var inactiveColor:UIColor = UIColor.grayColor() {
        didSet {
            updateColors()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayersIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: "hideBigCircle", forControlEvents: .TouchCancel)
        self.addTarget(self, action: "hideBigCircle", forControlEvents: .TouchUpOutside)
        self.addTarget(self, action: "toggleState", forControlEvents: .TouchUpInside)
        
        self.addTarget(self, action: "showBigCircle", forControlEvents: .TouchDown)
        createLayersIfNeeded()
    }

    private func createLayersIfNeeded() {
        if bigCircle == nil {
            bigCircle = CAShapeLayer()
            bigCircle!.bounds = CGRect(x: 0, y: 0, width: 48, height: 48)
            bigCircle!.position = CGPoint(x: 12, y: 12)
            bigCircle!.lineWidth = 0
            bigCircle!.fillColor = on ? activeColor.CGColor : inactiveColor.CGColor
            
            bigCircle!.opacity = 0
            
            let path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 48, height: 48))
            bigCircle!.path = path.CGPath
            self.layer.addSublayer(bigCircle!)
        }
        
        if outterCircle == nil {
            outterCircle = CAShapeLayer()
            outterCircle!.bounds = CGRect(x: 0, y: 0, width: 24, height: 24)
            outterCircle!.position = CGPoint(x: 12, y: 12)
            outterCircle!.lineWidth = 2
            outterCircle!.strokeColor = on ? activeColor.CGColor : inactiveColor.CGColor
            outterCircle!.fillColor = UIColor.clearColor().CGColor
            
            outterCircle!.masksToBounds = true
            
            let path = UIBezierPath(ovalInRect: CGRect(x: 1, y: 1, width: 22, height: 22))
            outterCircle!.path = path.CGPath
            self.layer.addSublayer(outterCircle!)
        }
        
        if innerCircle == nil {
            innerCircle = CAShapeLayer()
            innerCircle!.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
            innerCircle!.position = CGPoint(x: 12, y: 12)
            innerCircle!.lineWidth = 0
            innerCircle!.fillColor = on ? activeColor.CGColor : inactiveColor.CGColor
            
            innerCircle!.opacity =  on ? 1 : 0
            
            let path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 12, height: 12))
            innerCircle!.path = path.CGPath
            self.layer.addSublayer(innerCircle!)
        }
        
    }
    
    func toggleState() {
        hideBigCircle()
        if on { hideInnerCircle() } else { showInnerCircle() }
        on = !on
        self.sendActionsForControlEvents(.ValueChanged)
    }
    
    func updateColors() {
        if on {
            bigCircle!.fillColor = activeColor.CGColor
            outterCircle!.strokeColor = activeColor.CGColor
            innerCircle!.fillColor = activeColor.CGColor
            showInnerCircle()
        } else {
            bigCircle!.fillColor = inactiveColor.CGColor
            outterCircle!.strokeColor = inactiveColor.CGColor
            innerCircle!.fillColor = inactiveColor.CGColor
            hideInnerCircle()
        }
    }
    
    func hideInnerCircle() {
        innerCircle!.opacity = 0
        let transform = CABasicAnimation(keyPath: "transform.scale")
        transform.fromValue = 1
        transform.toValue = 0
        transform.duration = 0.2
        transform.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 1
        opacity.toValue = 0
        opacity.duration = 0.2
        
        innerCircle!.addAnimation(transform, forKey: "scaleDown")
        innerCircle!.addAnimation(transform, forKey: "opacityDown")
    }
    
    func showInnerCircle() {
        innerCircle!.opacity = 1
        let transform = CABasicAnimation(keyPath: "transform.scale")
        transform.fromValue = 0
        transform.toValue = 1
        transform.duration = 0.2
        transform.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0
        opacity.toValue = 1
        opacity.duration = 0.2
        
        innerCircle!.addAnimation(transform, forKey: "scaleUp")
        innerCircle!.addAnimation(transform, forKey: "opacityUp")
    }
    
    func showBigCircle() {
        bigCircle!.opacity = 0.1
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0
        opacity.toValue = 0.1
        opacity.duration = 0.35
        
        let transform = CABasicAnimation(keyPath: "transform.scale")
        transform.fromValue = 0.3
        transform.toValue = 1
        transform.duration = 0.35
        
        transform.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        bigCircle!.addAnimation(transform, forKey: "scaleUp")
        bigCircle!.addAnimation(opacity, forKey: "opacityUp")
    }
    
    func hideBigCircle() {
        bigCircle!.opacity = 0
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0.1
        opacity.toValue = 0
        opacity.duration = 0.35
        
        bigCircle!.addAnimation(opacity, forKey: "opacityDown")
    }

}
