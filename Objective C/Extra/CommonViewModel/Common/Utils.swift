
//  Utils.swift
//  SwiftProjectStructure
//
//  Created by Krishna Patel on 19/06/18.
//  Copyright © 2018 Krishna. All rights reserved.
//

import UIKit
import MBProgressHUD
import Reachability
import KSToastView

class Utils: NSObject {
    // MARK: - Common
    func connected() -> Bool {
        let reachability = Reachability.forInternetConnection()
        let status : NetworkStatus = reachability!.currentReachabilityStatus()
        if status == .NotReachable{
            return false
        } else {
            return true
        }
    }
    
    func makeCircular(view : UIView) {
        view.layer.cornerRadius = view.frame.size.height/2
        view.layer.masksToBounds = true
    }
    
    func getAppDelegate() -> Any? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func drawBorder(view: UIView?, color borderColor: UIColor?, width: Float, radius: Float) {
        view?.layer.borderColor = borderColor?.cgColor
        view?.layer.borderWidth = CGFloat(width)
        view?.layer.cornerRadius = CGFloat(radius)
        view?.layer.masksToBounds = true
    }
    
    func getThemeColor() -> UIColor {
        return UIColor(hexString: THEME_COLOR)
    }
    
    func doLogOut() {
        let userDefaults = UserDefaults.standard
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            if(key == sFCM_TOKEN){}
            else {
                userDefaults.removeObject(forKey: key)
            }
        }
        userDefaults.synchronize()
    }
    
    //MARK: - UserDefaults related Methods
    func setIsUserLoggegIn(status : Bool)  {
        UserDefaults.standard.set(status, forKey: sIS_USER_LOGGEDIN)
    }
    func getIsUserLoggegIn() -> Bool {
        return UserDefaults.standard.bool(forKey: sIS_USER_LOGGEDIN)
    }
    
    //Paging
    func setIsPagingDone(status: Bool) {
        UserDefaults.standard.set(status, forKey: sIS_PAGING_DONE)
    }
    func getIsPagingDone() -> Bool {
        return UserDefaults.standard.bool(forKey: sIS_PAGING_DONE)
    }
    
    //FCM Token
    func setFCMTOKEN(fcmToken : String) {
        UserDefaults.standard.set(fcmToken, forKey: sFCM_TOKEN)
    }
    func getFCMTOKEN() -> String {
        return UserDefaults.standard.value(forKey: sFCM_TOKEN) as! String
    }
    
    //Device Token
    func setDeviceToken(deviceToken: String) {
        UserDefaults.standard.set(deviceToken, forKey: sDEVICE_TOKEN)
    }
    func getDeviceToken() -> String {
        return UserDefaults.standard.value(forKey: sDEVICE_TOKEN) as! String
    }
    
    //User Latitude
    func setCurrentLat(currentLat : String) {
        UserDefaults.standard.set(currentLat, forKey: sCURRENT_LAT)
    }
    func getCurrentLat() -> String {
        if let latitude = UserDefaults.standard.value(forKey: sCURRENT_LAT) {
            print(latitude)
            return UserDefaults.standard.value(forKey: sCURRENT_LAT) as! String
        } else {
            return ""
        }
    }
    
    //User Longittude
    func setCurrentLong(currentLong : String) {
        UserDefaults.standard.set(currentLong, forKey: sCURRENT_LONG)
    }
    func getCurrentLong() -> String {
        if let longitude = UserDefaults.standard.value(forKey: sCURRENT_LONG) {
            print(longitude)
            return UserDefaults.standard.value(forKey: sCURRENT_LONG) as! String
        } else {
            return ""
        }
    }
    
    //Set User Data
    func setUserData(userData: NSDictionary) {
        UserDefaults.standard.set(userData, forKey: sUSER_DATA)
    }
    func getUserData() -> NSDictionary {
        return UserDefaults.standard.value(forKey: sUSER_DATA) as! NSDictionary
    }
    
    //MARK: - SMS id
    func setSMSId(SMSId: String)  {
        UserDefaults.standard.set(SMSId, forKey: sSMS_ID)
    }
    
    func getSMSId() -> String {
        if (UserDefaults.standard.value(forKey: sSMS_ID) != nil) {
            return UserDefaults.standard.value(forKey: sSMS_ID) as! String
        } else {
            return ""
        }
    }
    
    //MARK:- Card Detail
    func setCardDetail(cardDetail: NSDictionary) {
        UserDefaults.standard.set(cardDetail, forKey: sCARD_DETAIL)
    }
    func getCardData() -> NSDictionary {
        if(UserDefaults.standard.value(forKey: sCARD_DETAIL) != nil) {
            return UserDefaults.standard.value(forKey: sCARD_DETAIL) as! NSDictionary
        } else {
            return NSDictionary()
        }
    }
    
    //MARK:- Navigation To Payment Or Home
    func setIsFromHome(status: Bool) {
        UserDefaults.standard.set(status, forKey: sNAV_DETAIL)
    }
    func getIsFromHome() -> Bool {
        return UserDefaults.standard.bool(forKey: sNAV_DETAIL)
    }
    
    //MARK: - SHOW HUD
    func ShowHUD(inView : UIView)  {
        MBProgressHUD.showAdded(to: inView, animated: true)
    }
    
    func dismissHUD(fromView : UIView ) {
        MBProgressHUD.hide(for: fromView, animated: true)
    }
    
    func createBlankFooterView() -> UIView? {
        let blankFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0))
        blankFooterView.backgroundColor = UIColor.clear
        return blankFooterView
    }
    
    func createFooterView() -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30.0))
        footerView.backgroundColor = UIColor.clear
        let actInd = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        actInd.tag = 10
        actInd.color = getThemeColor()
        actInd.tintColor = getThemeColor()
        actInd.frame = CGRect(x: UIScreen.main.bounds.size.width / 2, y: 0, width: 10.0, height: 10.0)
        actInd.hidesWhenStopped = true
        footerView.addSubview(actInd)
        return footerView
    }
    
    //MARK:- KSToastView Method
    func showToast(message: Any?)  {
        KSToastView.ks_showToast(message)
    }
}
