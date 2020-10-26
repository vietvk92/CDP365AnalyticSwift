//
//  ANUtility.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

#if os(iOS) && canImport(CoreTelephony)
import CoreTelephony
#endif

#if canImport(WatchKit)
import WatchKit
#elseif canImport(UIKit)
import UIKit
#endif

#if canImport(WebKit)
import WebKit
#endif

#if canImport(AdSupport)
import AdSupport
#endif

#if canImport(AppTrackingTransparency)
import AppTrackingTransparency
#endif

#if canImport(CoreLocation)
import CoreLocation
#endif



class ANUtilities: NSObject {
    
    enum ConnexionType: String {
        case
        offline = "offline",
        fourg = "4g",
        wifi = "wifi",
        unknown = "unknown"
    }
    
    enum ANUtilitiesKey: String {
        case indexAnonymousID = "AN_Index_Anonymous"
    }
    
    class var anonymousID: String {
        get {
            let keychain = ANKeychainSwift()
            if let currentIndex = keychain.get(ANUtilitiesKey.indexAnonymousID.rawValue), currentIndex.count > 0 {
                return identifierForAdvertising + currentIndex
            }
            return "identifierForAdvertising"
        }
    }
    
    /// SDK Version
    class var sdkVersion: String {
        get {
            
            let version = Bundle(for: CDP365Analytic.self).infoDictionary!["CFBundleShortVersionString"] as? String
            
            if let optVersion = version {
                return String(format:"%@", optVersion)
            } else {
                return ""
            }
        }
    }
    
    /// SDK Build
    class var sdkBuild: String {
        get {
            
            let version = Bundle(for: CDP365Analytic.self).infoDictionary!["CFBundleVersion"] as? String
            
            if let optVersion = version {
                return String(format:"%@", optVersion)
            } else {
                return ""
            }
        }
    }
    
    class var sdkIdentifier: String {
        get {
            let identifier = Bundle(for: CDP365Analytic.self).infoDictionary?["CFBundleIdentifier"] as? String
            
            if let optIdentifier = identifier {
                return String(format:"%@", optIdentifier)
            } else {
                return "noSDKIdentifier"
            }
        }
    }
    
    /// Device language (eg. en_US)
    class var language: String {
        get {
            return Locale.autoupdatingCurrent.identifier.lowercased()
        }
    }
    
    class var locale: String {
        get {
            return Locale.current.languageCode ?? ""
        }
    }
    
    class var timeZone: String {
        get {
            return TimeZone.current.abbreviation() ?? ""
        }
    }
    
    
    class var deviceId: String {
        get {
            return UIDevice.current.identifierForVendor?.description ?? ""
        }
    }
    
    class var deviceName: String {
        get {
            return UIDevice.current.name
        }
    }
    
    class var deviceModel: String {
        get {
            return UIDevice.current.model
        }
    }
    
    class var osVersion: String {
        get {
            return UIDevice.current.systemVersion
        }
    }
    
    /// Device OS (name + version)
    @objc class var operatingSystem: String {
        get {
            #if canImport(WatchKit)
            return String(format: "[%@]-[%@]", WKInterfaceDevice.current().systemName.removeSpaces().lowercased(), WKInterfaceDevice.current().systemVersion)
            #elseif canImport(UIKit)
            return String(format: "[%@]-[%@]", UIDevice.current.systemName.removeSpaces().lowercased(), UIDevice.current.systemVersion)
            #else
            return ""
            #endif
        }
    }
    
    /// Application localized name
    class var applicationName: String {
        let defaultAppName = ANUtilities.applicationIdentifier
        if let info = Bundle.main.infoDictionary,  let name = info[String(kCFBundleNameKey)] as? String {
            if !name.isEmpty {
                return name
            }
        }
        if let localizedDic = Bundle.main.localizedInfoDictionary, let name = localizedDic[String(kCFBundleNameKey)] as? String {
            if !name.isEmpty {
                return name
            }
        }
        
        return defaultAppName
    }
    
    /// Application identifier (eg. com.atinternet.testapp)
    class var applicationIdentifier: String {
        get {
            let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
            
            if let optIdentifier = identifier {
                return String(format:"%@", optIdentifier)
            } else {
                return "noApplicationIdentifier"
            }
        }
    }
    
    /// Application version (eg. 5.0)
    class var applicationVersion: String {
        get {
            let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
            
            if let optVersion = version {
                return String(format:"%@", optVersion)
            } else {
                return ""
            }
        }
    }
    
    /// Application build
    class var applicationBuild: String {
        get {
            let build = Bundle.main.infoDictionary!["CFBundleVersion"] as? String
            
            if let optVersion = build {
                return String(format:"%@", optVersion)
            } else {
                return ""
            }
        }
    }
    
    /// IDFA
    class var identifierForAdvertising: String {
        #if canImport(AdSupport)
        let sharedASIdentifierManager = ASIdentifierManager.shared()
        var isTrackingEnabled: Bool
        
        #if os(tvOS)
        if #available(tvOS 14, *) {
            #if canImport(AppTrackingTransparency)
            isTrackingEnabled = ATTrackingManager.trackingAuthorizationStatus == ATTrackingManager.AuthorizationStatus.authorized
            #else
            isTrackingEnabled = false
            #endif
        } else {
            isTrackingEnabled = sharedASIdentifierManager.isAdvertisingTrackingEnabled
        }
        #else
        if #available(iOS 14, *) {
            #if canImport(AppTrackingTransparency)
            isTrackingEnabled = ATTrackingManager.trackingAuthorizationStatus == ATTrackingManager.AuthorizationStatus.authorized
            #else
            isTrackingEnabled = false
            #endif
        } else {
            isTrackingEnabled = sharedASIdentifierManager.isAdvertisingTrackingEnabled
        }
        #endif
        if isTrackingEnabled {
            return sharedASIdentifierManager.advertisingIdentifier.uuidString
        } else {
            return "opt-out"
        }
        #else
        return ""
        #endif
    }
    
    /// Wifi Address
    class var wifiAddress: String {
        var address = ""
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name: String = String(cString: (interface!.ifa_name))
                    if  name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    /// Screen width
    class var screenWidth: String {
        get {
            #if canImport(WatchKit)
            let screenBounds = WKInterfaceDevice.current().screenBounds
            let screenScale = WKInterfaceDevice.current().screenScale
            #elseif canImport(UIKit)
            let screenBounds = UIScreen.main.bounds
            let screenScale = UIScreen.main.scale
            #else
            let screenBounds = 0
            let screenScale = 0
            #endif
            
            return String(format:"%i", Int(screenBounds.size.width * screenScale))
        }
    }
    
    /// Screen height
    class var screenHeight: String {
        get {
            #if canImport(WatchKit)
            let screenBounds = WKInterfaceDevice.current().screenBounds
            let screenScale = WKInterfaceDevice.current().screenScale
            #elseif canImport(UIKit)
            let screenBounds = UIScreen.main.bounds
            let screenScale = UIScreen.main.scale
            #else
            let screenBounds = 0
            let screenScale = 0
            #endif
            
            return String(format:"%i",Int(screenBounds.size.height * screenScale))
        }
    }
    
    /// Carrier
    @objc class var carrier: String {
        get {
            #if os(iOS) && canImport(CoreTelephony) && !targetEnvironment(simulator)
            let networkInfo = CTTelephonyNetworkInfo()
            var provider : CTCarrier? = nil
            if #available(iOS 12, *) {
                provider = networkInfo.serviceSubscriberCellularProviders?.values.first
            } else {
                provider = networkInfo.subscriberCellularProvider
            }
            
            if let optProvider = provider {
                let carrier = optProvider.carrierName
                
                if carrier != nil {
                    return carrier!
                }
            } else {
                return ""
            }
            #endif
            return ""
        }
    }
    
    #if os(iOS) && canImport(WebKit)
    static var webView : WKWebView?
    #endif
    
    @objc static var _defaultUserAgent: String?
    @objc class var defaultUserAgent: String? {
        get {
            if _defaultUserAgent == nil {
                #if os(iOS) && canImport(WebKit)
                if self.webView == nil {
                    if Thread.isMainThread {
                        self.webView = WKWebView(frame: .zero)
                    } else {
                        DispatchQueue.main.sync {
                            self.webView = WKWebView(frame: .zero)
                        }
                    }
                }
                if self.webView != nil && !Thread.isMainThread {
                    let semaphore = DispatchSemaphore(value: 0)
                    DispatchQueue.main.sync {
                        self.webView!.evaluateJavaScript("navigator.userAgent") { (data, error) in
                            if let dataStr = data as? String {
                                _defaultUserAgent = dataStr
                            }
                            semaphore.signal()
                        }
                    }
                    _ = semaphore.wait(timeout: .distantFuture)
                }
                #endif
            }
            if _defaultUserAgent != nil {
                return String(format: "%@ %@/%@", _defaultUserAgent!, applicationName, applicationVersion)
            }
            return _defaultUserAgent
        }
    }
    
    /// Get user agent async
    static func getUserAgentAsync(completionHandler: @escaping ((String) -> Void)) {
        if _defaultUserAgent == nil {
            #if os(iOS) && canImport(WebKit)
            if self.webView == nil {
                if Thread.isMainThread {
                    self.webView = WKWebView(frame: .zero)
                } else {
                    DispatchQueue.main.sync {
                        self.webView = WKWebView(frame: .zero)
                    }
                }
            }
            if self.webView != nil {
                if Thread.isMainThread {
                    self.webView!.evaluateJavaScript("navigator.userAgent") { (data, error) in
                        if let dataStr = data as? String {
                            _defaultUserAgent = dataStr
                            completionHandler(String(format: "%@ %@/%@", _defaultUserAgent!, applicationName, applicationVersion))
                        } else {
                            completionHandler("")
                        }
                    }
                } else {
                    DispatchQueue.main.sync {
                        self.webView!.evaluateJavaScript("navigator.userAgent") { (data, error) in
                            if let dataStr = data as? String {
                                _defaultUserAgent = dataStr
                                completionHandler(String(format: "%@ %@/%@", _defaultUserAgent!, applicationName, applicationVersion))
                            } else {
                                completionHandler("")
                            }
                        }
                    }
                }
            }
            #endif
            return
        }
        if _defaultUserAgent != nil {
            completionHandler(String(format: "%@ %@/%@", _defaultUserAgent!, applicationName, applicationVersion))
        } else {
            completionHandler("")
        }
    }
    
    @objc static var _currentCity: String?
    @objc class var currentCity: String {
        get {
            return _currentCity ?? ""
        }
    }
    @objc static var _currentCountry: String?
    @objc class var currentCountry: String {
        get {
            return _currentCountry ?? ""
        }
    }
    @objc static var _currentLongitude: String?
    @objc class var currentLongitude: String {
        get {
            return _currentLongitude ?? ""
        }
    }
    @objc static var _currentLatitude: String?
    @objc class var currentLatitude: String {
        get {
            return _currentLatitude ?? ""
        }
    }
    /// Get location async
    static func getCurrentLocation() {
        ANLocation.sharedInstance.getCurrentReverseGeoCodedLocation { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            if error != nil {
                return
            }
            guard let _ = location else { return }
            _currentCity = placemark?.locality
            _currentCountry = placemark?.country
            _currentLongitude = String(format: "%f", (location?.coordinate.longitude ?? ""))
            _currentLatitude = String(format: "%f", (location?.coordinate.latitude ?? ""))
        }
    }
    
}
