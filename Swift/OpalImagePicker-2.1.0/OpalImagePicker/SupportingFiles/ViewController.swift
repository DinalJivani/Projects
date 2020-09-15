//
//  ViewController.swift
//  OpalImagePicker
//
//  Created by Kristos Katsanevas on 1/15/17.
//  Copyright © 2017 Opal Orange LLC. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func presentPicker() {
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self;
        
        //Change color of selection overlay to white
        imagePicker.selectionTintColor = UIColor.clear.withAlphaComponent(0.7)
        
        //Change color of image tint to black
        imagePicker.selectionImageTintColor = UIColor.black
        
        //Change image to X rather than checkmark
        imagePicker.selectionImage = UIImage(named: "checking-square1")
        
        //Change status bar style
        imagePicker.statusBarPreference = UIStatusBarStyle.lightContent
        
        //Limit maximum allowed selections to 5
        imagePicker.maximumSelectionsAllowed = 5
        
        //Only allow image media type assets
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        
        //Change default localized strings displayed to the user
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
        imagePicker.configuration = configuration
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK:- IBActions
    
    @IBAction func openImagePickerAction(_ sender: UIButton) {
        self.presentPicker()
    }
    
}

extension ViewController: OpalImagePickerControllerDelegate {
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingExternalURLs urls: [URL]) {
        print(urls)
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        print(images)
    }

    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        print(assets)
    }
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
        return URL(string: "https://placeimg.com/500/500/nature.php")
    }
    
    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
    }
    
    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
        return 1
    }
    
}
