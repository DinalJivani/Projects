//
//  UIViewExtension.swift
//  SwiftExtension
//
//  Created by EbitNHP-i1 on 07/08/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import UIKit

// Enum for gradient start and end points.
enum Points {
    case topLeft
    case topCenter
    case topRight
    case centerLeft
    case center
    case centerRight
    case bottomLeft
    case bottomCenter
    case bottomRight
}

extension UIView {
    
    /// The view's gradient background color.
    ///
    /// - Parameters:
    ///   - colors: An array of colors each representing a color in gradient background. Minimum two colors are required.
    ///   - startPoint: The start point of the gradient when drawn in the layer’s coordinate space.
    ///   - endPoint: The end point of the gradient when drawn in the layer’s coordinate space.
    func setGradientBackground(with colors: Array<UIColor>, startPoint: Points, endPoint: Points) {
        if colors.isEmpty || colors.count == 1 {
            print("Minimum two colors required for gradient")
            return
        }
        
        // Convert Color To CGColor
        var cgColors: Array<CGColor> = []
        for color in colors {
            cgColors.append(color.cgColor)
        }
        
        // Setting GradientLayer
        var startingPoint = CGPoint()
        var endingPoint = CGPoint()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = cgColors
        
        // Start Point Setup
        switch startPoint {
        case .topLeft:
            startingPoint = CGPoint(x: 0.0, y: 0.0)
            
        case .topCenter:
            startingPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .topRight:
            startingPoint = CGPoint(x: 1.0, y: 0.0)
            
        case .centerLeft:
            startingPoint = CGPoint(x: 0.0, y: 0.5)
            
        case .center:
            startingPoint = CGPoint(x: 0.5, y: 0.5)
            
        case .centerRight:
            startingPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .bottomLeft:
            startingPoint = CGPoint(x: 0.0, y: 1.0)

        case .bottomCenter:
            startingPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomRight:
            startingPoint = CGPoint(x: 1.0, y: 1.0)
        }
        
        // End Point Setup
        switch endPoint {
        case .topLeft:
            endingPoint = CGPoint(x: 0.0, y: 0.0)
            
        case .topCenter:
            endingPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .topRight:
            endingPoint = CGPoint(x: 1.0, y: 0.0)
            
        case .centerLeft:
            endingPoint = CGPoint(x: 0.0, y: 0.5)
            
        case .center:
            endingPoint = CGPoint(x: 0.5, y: 0.5)
            
        case .centerRight:
            endingPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .bottomLeft:
            endingPoint = CGPoint(x: 0.0, y: 1.0)
            
        case .bottomCenter:
            endingPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomRight:
            endingPoint = CGPoint(x: 1.0, y: 1.0)
        }
        
        gradientLayer.startPoint = startingPoint
        gradientLayer.endPoint = endingPoint
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
