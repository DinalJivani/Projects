//
//  Const.swift
//  SwiftProjectStructure
//
//  Created by Krishna Patel on 18/06/18.
//  Copyright © 2018 Krishna. All rights reserved.
//

import Foundation
import UIKit

//MARK: - USERDEFAULT RELATED
let sCURRENT_LAT    = "CURRENT_LAT"
let sCURRENT_LONG   = "CURRENT_LONG"
let sUSER_DATA      = "UserData"
let sCARD_DETAIL    = "CardDetail"
let sNAV_DETAIL     = "NavDetail"

//MARK: - SMS ID
let sSMS_ID = "SMS_ID"

//MARK: - CHECK FOR DEVICE
let IS_IPHONE4 = (UIScreen.main.bounds.size.height - 480) != 0.0 ? false : true
let IS_IPAD = UI_USER_INTERFACE_IDIOM() != .phone
let IS_IPHONE5s = UIScreen.main.bounds.size.height <= 568 ? true : false
let IS_IPHONEX = UIScreen.main.bounds.size.height == 812 ? true : false

//MARK: - SCREEN BOUNDS
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//MARK: - GET APPDELEGATE
let APPDELEGATE = UIApplication.shared.delegate as? AppDelegate

//MARK: - API HOST URL
let cWEBHOST = "http://ec2-18-224-180-145.us-east-2.compute.amazonaws.com/APIs/"

//MARK: - API NAMES
let cREGISTER = "register.php"
let cFORGOTPASS = "forgot_password.php"
let cLOGIN  = "login.php"
let cSIGNUP = "registration.php"
let cPHONE_EXIST = "phone_exists.php"
let cSOCIAL_LOGIN = "social_login.php"
let cCHANGE_PHONE = "change_phone.php"
let cUPDATE_PROFILE = "update_profile.php"
let cUPDATE_PAYMENT_DETAIL = "payment_detail.php"
let cLOCATION_LIST = "location_list.php"

//MARK: - NOTIFICATION NAMES
let nNOTIFICATION_LOGOUT   =    "logoutNotification"

//MARK: - SOME COMMON THINGS
let kCHECK_INTERNET_CONNECTION: NSString   =  "Check your internet connection"
let kPROBLEM_FROM_SERVER: NSString         =  "Problem Receiving Data From Server"

//MARK: - SOME ACCOUNT KEYS, e.g google, gmail, paypal, facebook, twitter

//MARK: - iTUNES URL for Share App
let iTunesURL = ""
let APPSTORE_APPID  = ""

//MARK: - FONT NAMES
let fFONT_REGULAR   =   "HelveticaNeue"
let fFONT_BOLD      =   "HelveticaNeue-Bold"
let fFONT_MEDIUM    =   "HelveticaNeue-Medium"

//MARK: - USER TYPE IF MORE USER

//MARK: - USERDEFAULT RELATED
let sIS_USER_LOGGEDIN   = "IsUserLoggedIn"
let sFCM_TOKEN          = "FCM_TOKEN"
let sIS_PAGING_DONE     = "IsPagingDone"
let sDEVICE_TOKEN       = "DeviceToken"

//MARK: - SET APP THEME COLOR
let THEME_COLOR        = "40b9f8"
let PLACEHOLDER_COLOR  = "809FAE"

//MARK: - Title Message
let ALERT_TITLE = "FIBOW"

