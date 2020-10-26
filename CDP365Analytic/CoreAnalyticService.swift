//
//  CoreAnalyticService.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

protocol CoreAnalyticService {
    static func configure()
    static func logEvent(screenName: String)
    static func logEvent(categoryName: String, actionName: String, items:[NSDictionary]?, extra: NSDictionary?, dimension: [NSDictionary]?)
    static func resetAnonymousId()
}

@objc protocol FacebookProtocolService {
    @objc optional static func logEvent(_ eventName: String)
    @objc optional static func logEvent(_ eventName: String, parameters: Parameters?)
}

@objc protocol GoogleProtocolService {
    @objc optional static func configure()
    @objc optional static func logEventWithName(_ name: String?, parameters: Parameters?)
    @objc optional static func setScreenName(_ screenName: String?, screenClass: String?)
}

