//
//  ANConfiguration.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

@objcMembers
class ANConfigurationKeys: NSObject {
    /// Actions
    static let ActionResetAnonymousId                  = "reset_anonymous_id"
    /// Querry Params
    static let QueryParamsPortalID                     = "portal_id"
    static let QueryParamsPropertyID                   = "prop_id"
    static let QueryParamsResponseType                 = "resp_type"
    static let QueryParamsFormat                       = "format"
    
    /// Body Params
    static let BodyParamsUserID                        = "uid"
    static let BodyParamsAdvertisingID                 = "aid"
    static let BodyParamsSessionID                     = "sid"
    static let BodyParamsEventCategory                 = "ec"
    static let BodyParamsEventAction                   = "ea"
    
    static let BodyParamsContext                       = "context"
    static let BodyParamsIP                            = "ip"
    static let BodyParamsLocale                        = "locale"
    static let BodyParamsNavigation                    = "navigation"
    static let BodyParamsTimeZone                      = "timezone"
    static let BodyParamsUserAgent                     = "userAgent"
    
    static let BodyParamsExtra                         = "extra"
    static let BodyParamsItems                         = "items"
    static let BodyParamsDimension                     = "dims"
    
    static let BodyParamsResetUID                      = "reset_uid"
    static let BodyParamsGenerateUID                   = "generate_uid"
    /**
     * App
     */
    static let  BodyParamsApp                          = "app"
    static let  BodyParamsAppName                      = "name"
    static let  BodyParamsAppVersion                   = "version"
    static let  BodyParamsAppBuild                     = "build"
    
    /**
     * SDK
     */
    static let  BodyParamsSDK                          = "sdk"
    static let  BodyParamsSDKName                      = "name"
    static let  BodyParamsSDKVersion                   = "version"
    static let  BodyParamsSDKBuild                     = "build"
    
    /**
     * Campaign
     */
    static let  BodyParamsCampaign                     = "campaign"
    static let  BodyParamsCampaignName                 = "name"
    static let  BodyParamsCampaignSource               = "source"
    static let  BodyParamsCampaignMedium               = "medium"
    static let  BodyParamsCampaignTerm                 = "term"
    static let  BodyParamsCampaignContent              = "content"
    
    /**
     * Device
     */
    static let  BodyParamsDevice                       = "device"
    static let  BodyParamsDeviceID                     = "id"
    static let  BodyParamsDeviceAdvertisingID          = "advertisingId"
    static let  BodyParamsDeviceAdTrackingEnable       = "adTrackingEnabled"
    static let  BodyParamsDeviceManufacturer           = "manufacturer"
    static let  BodyParamsDeviceModel                  = "model"
    static let  BodyParamsDeviceName                   = "name"
    static let  BodyParamsDeviceType                   = "type"
    
    /**
     * Geofencing
     */
    static let  BodyParamsGeofencing                   = "geo"
    static let  BodyParamsGeofencingCity               = "city"
    static let  BodyParamsGeofencingCountry            = "country"
    static let  BodyParamsGeofencingLatitude           = "latitude"
    static let  BodyParamsGeofencingLongitude          = "longitude"
    
    /**
     * Network
     */
    static let  BodyParamsNetwork                      = "network"
    static let  BodyParamsNetworkBluetooth             = "bluetooth"
    static let  BodyParamsNetworkCarrier               = "carrier"
    static let  BodyParamsNetworkCellular              = "cellular"
    static let  BodyParamsNetworkWifi                  = "wifi"
    
    /**
     * OS
     */
    static let  BodyParamsOS                           = "os"
    static let  BodyParamsOSName                       = "name"
    static let  BodyParamsOSVersion                    = "version"
    
    /**
     * Referrer
     */
    static let  BodyParamsReferrer                     = "referrer"
    static let  BodyParamsReferrerID                   = "id"
    static let  BodyParamsReferrerName                 = "name"
    static let  BodyParamsReferrerType                 = "type"
    
    /**
     * Screen
     */
    static let  BodyParamsScreen                       = "screen"
    static let  BodyParamsScreenWidth                  = "width"
    static let  BodyParamsScreenHeight                 = "height"
    
}

class ANConfiguration: NSObject {
    
    var value: ANConfigure?
    
    override init() {
        super.init()
        let url = Bundle.main.url(forResource: "CDP365_Config", withExtension: "plist")
        if let url = url {
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            do {
                let configure = try PropertyListDecoder().decode(ANConfigure.self, from: data)
                self.value = configure
            } catch {
                print(error)
            }
        }
        
    }
    
}
