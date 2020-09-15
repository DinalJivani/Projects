//
//  CommonMethods.swift
//  SwiftProjectStructure
//
//  Created by Krishna Patel on 29/06/18.
//  Copyright © 2018 Krishna. All rights reserved.
//

import Foundation
import UIKit

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

func PUSH(v: UIViewController)  {

    APPDELEGATE?.navigation.pushViewController(v, animated: true)
}

func POP() {
    APPDELEGATE?.navigation.popViewController(animated: true)
}

func PRESENT_VC(v : UIViewController) {
    APPDELEGATE?.navigation.present(v, animated: true, completion: nil)
}

func DISMISS_VC() {
    APPDELEGATE?.navigation.dismiss(animated: true, completion: nil)
}

///Assign CornerRadius, Border
func commonTextField(textField: UITextField) {
    textField.layer.cornerRadius = textField.frame.size.height/2
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.borderStyle = .none
}

func radiusToTextField(textField: UITextField, radius: CGFloat) {
    let color = UIColor.init(hexString: THEME_COLOR)
    textField.layer.cornerRadius = radius
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = color.cgColor
}

func roundButton(button: UIButton) {
    button.layer.cornerRadius = button.frame.size.height/2
}

func radiusToButton(button: UIButton, radius: CGFloat) {
    button.layer.cornerRadius = radius
}

func roundButtonWithBorder(button: UIButton) {
    let color = UIColor.init(hexString: THEME_COLOR)
    button.layer.cornerRadius = button.frame.size.height/2
    button.layer.borderWidth = 2.0
    button.layer.borderColor = color.cgColor
}

func roundAndBorder(button: UIButton) {
    let color = UIColor.init(hexString: THEME_COLOR)
    button.layer.cornerRadius = button.frame.size.height/2
    button.layer.borderWidth = 1.0
    button.layer.borderColor = color.cgColor
}

func vwWithShadow(view: UIView) {
    view.layer.cornerRadius = 10
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize.zero
    view.layer.shadowRadius = 1
    view.layer.shadowOpacity = 0.7
}

func shadowToView(view: UIView){
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowRadius = 5
    view.layer.shadowOffset = CGSize.zero
}

func radiusToView(view: UIView) {
    view.layer.cornerRadius = 8
}

func borderWithRadius(view: UIView) {
    let color = UIColor.init(hexString: THEME_COLOR)
    view.layer.cornerRadius = 8
    view.layer.borderColor = color.cgColor
    view.layer.borderWidth = 0.5
}

func roundImageViewWithBorder(imageView: UIImageView) {
    let color = UIColor.init(hexString: THEME_COLOR)
    imageView.layer.cornerRadius = imageView.frame.size.height/2
    imageView.layer.borderWidth = 3.5
    imageView.layer.borderColor = color.cgColor
}

func coloredPlaceHoler(textField: UITextField, placeHolder: String) {
    let color = UIColor.init(hexString: PLACEHOLDER_COLOR)
    textField.attributedPlaceholder = NSAttributedString(
                string: placeHolder,
                attributes: [NSAttributedStringKey.foregroundColor: color])
}

func textFieldView(textField: UITextField, direction: String) {
    let txtFieldView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 46.0, height: 46.0))
    if direction == "left" {
        textField.leftView = txtFieldView
        textField.leftViewMode = .always
    } else {
        textField.rightView = txtFieldView
        textField.rightViewMode = .always
    }
}

func textFieldCustomView(textField: UITextField, direction: String, width: Double, height: Double) {
    let txtFieldView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
    if direction == "left" {
        textField.leftView = txtFieldView
        textField.leftViewMode = .always
    } else {
        textField.rightView = txtFieldView
        textField.rightViewMode = .always
    }
}

func textFieldTwenty(textField: UITextField, direction: String) {
    let txtFieldView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 46.0))
    if direction == "left" {
        textField.leftView = txtFieldView
        textField.leftViewMode = .always
    } else {
        let txtFieldRView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 67.0, height: 46.0))
        textField.rightView = txtFieldRView
        textField.rightViewMode = .always
    }
}

func addBottomLineTo(textfield: UITextField)  {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: textfield.frame.height - 0.5, width: textfield.frame.size.width, height: 0.5)
    bottomLine.backgroundColor = UIColor.gray.cgColor
    textfield.borderStyle = UITextBorderStyle.none
    textfield.layer.addSublayer(bottomLine)
}

func addBottomToButton(button: UIButton, title: String) {
    // Colored Underline Label
    let color = UIColor.init(hexString: THEME_COLOR)
    let strBtnTitle = title
    let textColor: UIColor = color
    let underLineColor: UIColor = color
    let underLineStyle = NSUnderlineStyle.styleSingle.rawValue
    
    let strAtributes:[NSAttributedStringKey : Any]  = [
        NSAttributedStringKey.foregroundColor: textColor,
        NSAttributedStringKey.underlineStyle: underLineStyle,
        NSAttributedStringKey.underlineColor: underLineColor
    ]
    
    let underlineAttributedString = NSAttributedString(
                                    string: strBtnTitle,
                                    attributes: strAtributes)
    
    button.setAttributedTitle(underlineAttributedString, for: UIControlState.normal)
}

func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
    let lineView = UIView()
    lineView.backgroundColor = color
    lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
    view.addSubview(lineView)
    
    let metrics = ["width" : NSNumber(value: width)]
    let views = ["lineView" : lineView]
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
    
    switch position {
    case .LINE_POSITION_TOP:
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
        break
    case .LINE_POSITION_BOTTOM:
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
        break
   
    }
}

//MARK:- Corner Radius of only two side of UIViews
func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
    let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    view.layer.mask = mask
}

//MARK:- to show the toast
func showToast(message : String, view: UIView) {
    
    let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 100, y: view.frame.size.height-100, width: 200, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
