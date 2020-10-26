//
//  CDP365Analytic.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

@objc public class CDP365Analytic: NSObject, CoreAnalyticService {
    
    static var services: [CoreAnalyticService.Type] = [ANAnalyticService.self]
    
    @objc public static func configure() {
        services.forEach {$0.configure()}
    }
    
    @objc public static func logEvent(screenName: String) {
        services.forEach {$0.logEvent(screenName: screenName)}
    }
    
    @objc public static func logEvent(categoryName: String, actionName: String, items: [NSDictionary]? = nil, extra: NSDictionary? = nil, dimension: [NSDictionary]? = nil) {
        services.forEach {$0.logEvent(categoryName: categoryName, actionName: actionName, items: items, extra: extra, dimension: dimension)}
    }
    
    @objc public static func resetAnonymousId() {
        services.forEach {$0.resetAnonymousId()}
    }
    
    
}
