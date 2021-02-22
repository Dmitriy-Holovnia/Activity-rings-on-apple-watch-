//
//  RingView.swift
//  RingViewApp
//
//  Created by cr3w on 22.02.2021.
//

import UIKit

class RingView: UIView {
    
    //MARK: Variables
    private let value: CGFloat
    private let ringWidth: CGFloat
    private let animationDuration: CFTimeInterval
    private let color: UIColor
    
    // Calculate variables
    private var radius: CGFloat {
        (min(bounds.height, bounds.width) - ringWidth) / 2
    }
    
    private var circleCenter: CGPoint {
        CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    private var startAngle: CGFloat {
        -CGFloat.pi / 2
    }
    
    private var endAngle: CGFloat {
        (.pi * 2) * value
    }
    
    private var darkerColor: UIColor {
        color.darker(by: 30 * value)
    }
    
    
    // MARK: - Initialization
    init(frame: CGRect, value: CGFloat, ringWidth: CGFloat = 20, color: UIColor = .red, animationDuration: CFTimeInterval = 1) {
        self.value = value
        self.ringWidth = ringWidth
        self.color = color
        self.animationDuration = animationDuration
        super.init(frame: frame)
        self.setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layers
    private func setupLayers() {
        
        let ringLayer = CALayer()
        
        // Paths
        let backgroundPath = UIBezierPath(
            arcCenter: circleCenter,
            radius: radius,
            startAngle: startAngle,
            endAngle: startAngle - endAngle,
            clockwise: false
        ).cgPath
        
        
        //MARK: Background
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.backgroundColor = UIColor.black.cgColor
        
        // Background animation
        let strokeEndAnimation = CABasicAnimation()
        strokeEndAnimation.beginTime = 0
        strokeEndAnimation.duration = animationDuration
        strokeEndAnimation.fillMode = .forwards
        strokeEndAnimation.isRemovedOnCompletion = false
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        strokeEndAnimation.keyPath = "strokeEnd"
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.fromValue = 0
        
        backgroundLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")
        backgroundLayer.path = backgroundPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.black.cgColor
        backgroundLayer.lineCap = .round
        backgroundLayer.lineWidth = ringWidth
        
        
        //MARK: Gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "Gradient"
        gradientLayer.frame = frame
        
        // Gradient animation
        let transformRotationZAnimation = CABasicAnimation()
        transformRotationZAnimation.beginTime = 0
        transformRotationZAnimation.duration = animationDuration
        transformRotationZAnimation.fillMode = .forwards
        transformRotationZAnimation.isRemovedOnCompletion = false
        transformRotationZAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transformRotationZAnimation.keyPath = "transform.rotation.z"
        transformRotationZAnimation.toValue = endAngle
        
        gradientLayer.add(transformRotationZAnimation, forKey: "transformRotationZAnimation")
        gradientLayer.colors = [darkerColor.cgColor, color.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.type = .conic
        gradientLayer.mask = backgroundLayer
        
        
        //MARK: Tip
        let tipLayerLayer = CALayer()
        tipLayerLayer.bounds = CGRect(x: 0, y: 0, width: ringWidth, height: ringWidth)
        tipLayerLayer.position = circleCenter
        tipLayerLayer.anchorPoint = CGPoint(x: 0.5, y: bounds.height / 2 / ringWidth)
        tipLayerLayer.backgroundColor = color.cgColor
        tipLayerLayer.cornerRadius = ringWidth / 2
        tipLayerLayer.shadowOffset = CGSize(width: 0, height: 1)
        
        // TipLayer animation
        let tipTransformAnimation = CABasicAnimation()
        tipTransformAnimation.beginTime = 0
        tipTransformAnimation.duration = animationDuration
        tipTransformAnimation.fillMode = .forwards
        tipTransformAnimation.isRemovedOnCompletion = false
        tipTransformAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        tipTransformAnimation.keyPath = "transform.rotation.z"
        tipTransformAnimation.toValue = endAngle
        tipLayerLayer.add(tipTransformAnimation, forKey: "tipTransformAnimation")
        
        // Add sub layers
        ringLayer.addSublayer(gradientLayer)
        ringLayer.addSublayer(tipLayerLayer)
        self.layer.addSublayer(ringLayer)
    }
}

