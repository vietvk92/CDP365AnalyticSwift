//
//  GoogleAnalyticService.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

class GoogleAnalyticService: CoreAnalyticService, GoogleProtocolService {
    
    static func configure() {}
    static func logEvent(screenName: String) {}
    static func logEvent(categoryName: String, actionName: String, items: [NSDictionary]?, extra: NSDictionary?, dimension: [NSDictionary]?) {}
    static func resetAnonymousId() {}
    
}
