//
//  UIColorExtension.swift
//  SwiftExtension
//
//  Created by EbitNHP-i1 on 05/08/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// Initializes and returns a color object using the specified HexString values. Returns nil if hexstring is not valid.
    ///
    /// - Parameters:
    ///   - hexString: The `HexString` of color.
    /// - Returns: Returns color object. The color information represented by this object is in an RGB colorspace.
    public convenience init?(hexString: String) {
        
        var chars = Array(hexString.uppercased().hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            print("Invalid HexString, number of characters after '#' should be either 3, 6 or 8")
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: 1)
    }
    
}
