//
//  ViewController.swift
//  SwiftExtension
//
//  Created by EbitNHP-i1 on 03/08/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtContact: FPNTextField!
    @IBOutlet var btnValidate: UIButton!
    @IBOutlet var vwShadow: UIView!
    
    //MARK:- UIViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Color using HexString
        if let blackColor = UIColor.init(hexString: "000000") {
            self.view.backgroundColor = blackColor
        }
        
        // Set gradient background to view
        self.view.setGradientBackground(with: [.blue, .yellow], startPoint: .topLeft, endPoint: .topRight)
        
        // Left View To Textfield
        txtEmail.setImage(atSide: .left, imageName: "green_setting", imageSize: CGSize(width: 20, height: 20))
        
        // Setup country picker
        self.countryPickerSetup()
        
        self.vwShadow.layer.cornerRadius = 20
    }
        
    //MARK:- IBActions
    
    @IBAction func validateAction(_ sender: UIButton) {
        print(txtEmail.isValidEmail())
    }
    
    //MARK:- Custom Fuctions
    
    func countryPickerSetup() {
        // Set Delegate
        txtContact.delegate = self
        
        // Set Default Selected Country
        txtContact.setFlag(for: FPNOBJCCountryKey.IN)
        
        // For Display Search Button In Picker
        txtContact.parentViewController = self
    }
    
    func getAllCountryName() {
        var countries: [String] = []
        
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
            var symbol: String {
                return (Locale.current as NSLocale).displayName(forKey: .currencySymbol, value: code) ?? ""
            }
        }
        print(countries.sorted())
    }
    
}

//MARK:- FPNTextField Delegate

extension ViewController: FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code) // Output "France", "+33", "FR"
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            print(textField.getFormattedPhoneNumber(format: .E164)!)           // Output "+33600000001"
            print(textField.getFormattedPhoneNumber(format: .International)!)  // Output "+33 6 00 00 00 01"
            print(textField.getFormattedPhoneNumber(format: .National)!)       // Output "06 00 00 00 01"
            print(textField.getFormattedPhoneNumber(format: .RFC3966)!)        // Output "tel:+33-6-00-00-00-01"
            print(textField.getRawPhoneNumber()!)                               // Output "600000001"
        } else {
            // Do something...
        }
    }
    
}
