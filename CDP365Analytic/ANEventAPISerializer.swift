//
//  ANEventAPISerializer.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

class ANEventAPISerializer {
    
    internal func json(forEvent event: ANEvent) throws -> Data {
        
        let body = NSMutableDictionary()
        ANUtilities.getCurrentLocation()
        
        // Required
        var paramsRequired: Parameters = [:]
        paramsRequired = [
            ANConfigurationKeys.BodyParamsUserID: ANUtilities.anonymousID,
            ANConfigurationKeys.BodyParamsAdvertisingID: ANUtilities.identifierForAdvertising,
            ANConfigurationKeys.BodyParamsSessionID: ANSession.sessionID,
            ANConfigurationKeys.BodyParamsEventCategory: event.categoryName,
            ANConfigurationKeys.BodyParamsEventAction: event.actionName
        ]
        body.addEntries(from: paramsRequired)
        
        // Context Params
        var paramsContext: Parameters = [:]
        paramsContext = [
            ANConfigurationKeys.BodyParamsContext: getParamFromContext(eventName: event.screenName)
        ]
        body.addEntries(from: paramsContext)
        
        // Extra Params
        var paramExtra: Parameters = [:]
        if let extra = event.extra {
            paramExtra = [
                ANConfigurationKeys.BodyParamsExtra: extra
            ]
        }
        if event.actionName == ANConfigurationKeys.ActionResetAnonymousId {
            paramExtra.updateValue(ANUtilities.anonymousID, forKey: ANConfigurationKeys.BodyParamsResetUID)
            paramExtra.updateValue(ANUtilities.anonymousID.nextID(), forKey: ANConfigurationKeys.BodyParamsGenerateUID)
        }
        body.addEntries(from: paramExtra)
        
        // Item Params
        if let items = event.items {
            let paramItems = [
                ANConfigurationKeys.BodyParamsItems: items
            ]
            body.addEntries(from: paramItems)
        }
        
        // Dims Params
        if let dimension = event.dimension {
            let paramDims = [
                ANConfigurationKeys.BodyParamsDimension: dimension
            ]
            body.addEntries(from: paramDims)
        }
        
        return try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    }
    
    internal func getParamFromContext(eventName: String) -> Parameters {
        
        var params: Parameters = [:]
        
        // App param
        var appParam: Parameters = [:]
        appParam = [
            ANConfigurationKeys.BodyParamsAppName: ANUtilities.applicationName,
            ANConfigurationKeys.BodyParamsAppVersion: ANUtilities.applicationVersion,
            ANConfigurationKeys.BodyParamsAppBuild: ANUtilities.applicationBuild
        ]
        
        // SDK param
        var sdkParam: Parameters = [:]
        sdkParam = [
            ANConfigurationKeys.BodyParamsSDKName: "CDP365Anlytic SDK V3 on iOS",
            ANConfigurationKeys.BodyParamsSDKVersion: ANUtilities.sdkVersion,
            ANConfigurationKeys.BodyParamsSDKBuild: ANUtilities.sdkBuild
        ]
        
        // Device param
        var deviceParam: Parameters = [:]
        deviceParam = [
            ANConfigurationKeys.BodyParamsDeviceID: ANUtilities.deviceId,
            ANConfigurationKeys.BodyParamsDeviceAdvertisingID: ANUtilities.identifierForAdvertising,
            ANConfigurationKeys.BodyParamsDeviceAdTrackingEnable: "true",
            ANConfigurationKeys.BodyParamsDeviceManufacturer: "Apple",
            ANConfigurationKeys.BodyParamsDeviceModel: ANUtilities.deviceModel,
            ANConfigurationKeys.BodyParamsDeviceName: ANUtilities.deviceName,
            ANConfigurationKeys.BodyParamsDeviceType: "iOS"
        ]
        
        // Geofencing param
        var geoParam: Parameters = [:]
        geoParam = [
            ANConfigurationKeys.BodyParamsGeofencingCity: ANUtilities.currentCity,
            ANConfigurationKeys.BodyParamsGeofencingCountry: ANUtilities.currentCountry,
            ANConfigurationKeys.BodyParamsGeofencingLongitude: ANUtilities.currentLongitude,
            ANConfigurationKeys.BodyParamsGeofencingLatitude: ANUtilities.currentLatitude
        ]
        
        // Network param
        var networkParam: Parameters = [:]
        networkParam = [
            ANConfigurationKeys.BodyParamsNetworkCarrier: ANUtilities.carrier,
            ANConfigurationKeys.BodyParamsNetworkCellular: ((ANUtilities.wifiAddress.count > 0) ? "false" : "true"),
            ANConfigurationKeys.BodyParamsNetworkWifi: ((ANUtilities.wifiAddress.count > 0) ? "true" : "false")
        ]
        
        // OS param
        var osParam: Parameters = [:]
        osParam = [
            ANConfigurationKeys.BodyParamsOSName: "iOS",
            ANConfigurationKeys.BodyParamsOSVersion: ANUtilities.osVersion
        ]
        
        // Screen param
        var screenParam: Parameters = [:]
        screenParam = [
            ANConfigurationKeys.BodyParamsScreenWidth: ANUtilities.screenWidth,
            ANConfigurationKeys.BodyParamsScreenHeight: ANUtilities.screenHeight
        ]
        
        params = [
            ANConfigurationKeys.BodyParamsApp: appParam,
            ANConfigurationKeys.BodyParamsSDK: sdkParam,
            ANConfigurationKeys.BodyParamsDevice: deviceParam,
            ANConfigurationKeys.BodyParamsIP: ANUtilities.wifiAddress,
            ANConfigurationKeys.BodyParamsLocale: ANUtilities.locale,
            ANConfigurationKeys.BodyParamsGeofencing: geoParam,
            ANConfigurationKeys.BodyParamsNetwork: networkParam,
            ANConfigurationKeys.BodyParamsOS: osParam,
            ANConfigurationKeys.BodyParamsNavigation: eventName,
            ANConfigurationKeys.BodyParamsScreen: screenParam,
            ANConfigurationKeys.BodyParamsTimeZone: ANUtilities.timeZone,
            ANConfigurationKeys.BodyParamsUserAgent: ANUtilities.defaultUserAgent ?? ""
        ]
        
        return params
    }
}
