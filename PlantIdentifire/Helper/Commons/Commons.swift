//
//  Commons.swift
//  PlantIdentifire
//
//  Created by admin on 28/11/22.
//

import Foundation
import UIKit
import GoogleMobileAds
import SVProgressHUD
import Toaster

var arrId = [String]()

var arrOfObjectsOfImage = [Images]()

let appDelegate = UIApplication.shared.delegate as! AppDelegate

let PRIVACY_POLICY      = "https://swainfosolution.wordpress.com/privacy-policy/"
let TERM_AND_CONDITION  = "https://swainfosolution.wordpress.com/terms-condition/"

let IS_SUBSCRIBE                      = "IS_SUBSCRIBE_KEY"
let IS_FREE_SCAN                      = "IS_FREE_SCAN"
let SCAN_COUNT                        = "SCAN_COUNT"

let SHARE_SECRET = "9269f8b14b7c4d5ebca0e0cf193e7e29"

let IN_APP_PURCHASE_IDS = ["com.swainfo.PlantIdentifire.yearly"]
enum URLTypes: String {
    
    case contactUs = "https://pipaliyasmit.wordpress.com/contactus/"
    case privacyPolicy = "https://swainfosolution.wordpress.com/privacy-policy/"
    case shareApp = "https://apps.apple.com/in/app/plant-identifier/id1660916701"
    
}

enum adMob: String {
    
// //    Production
    case bannerAdID = "ca-app-pub-8252529408738635/7601503906"
    case interstitialAdID = "ca-app-pub-8252529408738635/6436332717"
    case nativeAdID = "ca-app-pub-8252529408738635/5410454834"
    case openAdID = "ca-app-pub-8252529408738635/3810169376"
    
    
//    // Development
//   case bannerAdID = "ca-app-pub-3940256099942544/2934735716"
//    case interstitialAdID = "ca-app-pub-3940256099942544/4411468910"
//    case nativeAdID = "ca-app-pub-3940256099942544/3986624511"
//    case openAdID = "ca-app-pub-3940256099942544/5662855259"
//
//    struct GOOGLE_ADS { // Google Testing Ads
//        static var AppId            = "ca-app-pub-3940256099942544~1458002511"
//        static var OpenAds          = "ca-app-pub-3940256099942544/5662855259"
//        static var BannerAds        = "ca-app-pub-3940256099942544/2934735716"
//        static var NativeAds        = "ca-app-pub-3940256099942544/3986624511"
//        static var InterstitialAds  = "ca-app-pub-3940256099942544/4411468910"
//    }
    
    
}

// MARK: - Toast
func displayToast(_ message: String) {
    Toast.init(text: message).show()
}

// MARK: - Show loader
func showLoader() {
    appDelegate.window?.isUserInteractionEnabled = false
    ProgressHUD.animationType = .systemActivityIndicator
    ProgressHUD.colorAnimation = UIColor.init(named: "AppColor") ?? UIColor.black
    ProgressHUD.show()
}

func removeLoader() {
    appDelegate.window?.isUserInteractionEnabled = true
    ProgressHUD.dismiss()
}



// MARK: - User defaults methods
func setDataToPreference(data: AnyObject, forKey key: String) {
    UserDefaults.standard.set(data, forKey: key)
    UserDefaults.standard.synchronize()
}

func getDataFromPreference(key: String) -> AnyObject? {
    return UserDefaults.standard.object(forKey: key) as AnyObject?
}
// MARK: - Subscribe Methods
func setIsUserSubscribe(isSubscribe: Bool) {
    setDataToPreference(data: isSubscribe as AnyObject, forKey: IS_SUBSCRIBE)
}

func isUserSubscribe() -> Bool {
    let isAccepted = getDataFromPreference(key: IS_SUBSCRIBE)
    return isAccepted == nil ? false : (isAccepted as! Bool)
}

func setFreeScan() {
    if var scanCount = getFreeScan() as? Int, scanCount < 3 {
        scanCount += 1
        setDataToPreference(data: scanCount as AnyObject, forKey: SCAN_COUNT)
    }
}

func getFreeScan() -> Int {
    let isAccepted = getDataFromPreference(key: SCAN_COUNT)
    return isAccepted == nil ? 0 : (isAccepted as! Int)
}
