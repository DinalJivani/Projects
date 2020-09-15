//
//  UITextFieldExtension.swift
//  SwiftExtension
//
//  Created by EbitNHP-i1 on 03/08/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import UIKit
import Foundation

enum Alignment {
    case left
    case right
}

extension UITextField {
    
    /// Check if email address is valid or not.
    ///
    /// Returns `Bool` telling that email is valid or not.
    func isValidEmail() -> Bool {
        if self.text?.count ?? 0 < 1 {
            return false
        }
        
        if self.text?.isContainsEmoji ?? false {
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.text)
    }
    
    /// Set Image inside UITextfield at specified size.
    ///
    /// - Parameters:
    ///   - side: Alignment for the image position.
    ///   - imageName: The name of the image.
    ///   - imageSize: The size for the image.
    func setImage(atSide side: Alignment, imageName: String, imageSize: CGSize) {
        let imageView = UIImageView(frame: CGRect(x: (self.frame.size.height - imageSize.height) / 2, y: (self.frame.size.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height))
        imageView.image = UIImage(named: imageName)
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        mainView.addSubview(imageView)
        mainView.clipsToBounds = true
        
        switch side {
        case .left:
            self.leftViewMode = .always
            self.leftView = mainView
        case .right:
            self.rightViewMode = .always
            self.rightView = mainView
        }
    }
    
}
