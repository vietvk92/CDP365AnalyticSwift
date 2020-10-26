//
//  ANAnalyticService.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

class ANAnalyticService: CoreAnalyticService {
    
    private static var dispatcher: ANDispatcher = ANSender(configure: ANConfiguration())
    
    static func configure() {
        ANSession.startNewSession()
    }
    
    static func logEvent(screenName: String) {
        let event = ANEvent(screenName: screenName, categoryName: "screen", actionName: "view")
        dispatcher.send(event: event, success: {
            ANLogger.debug("Dispatched batch of event.")
        }, failure: { error in
            ANLogger.error(error)
        })
    }
    
    static func logEvent(categoryName: String, actionName: String, items: [NSDictionary]?, extra: NSDictionary?, dimension: [NSDictionary]?) {
        let event = ANEvent(categoryName: categoryName, actionName: actionName, items: items, extra: extra, dimension: dimension)
        dispatcher.send(event: event, success: {
            ANLogger.debug("Dispatched batch of event.")
        }, failure: { error in
            ANLogger.error(error)
        })
    }
    
    static func resetAnonymousId() {
        let event = ANEvent(screenName: "", categoryName: "user", actionName: ANConfigurationKeys.ActionResetAnonymousId)
        dispatcher.send(event: event, success: {
            ANLogger.debug("Dispatched batch of event.")
            ANUtilities.anonymousID.nextID().storageIndexAnonymous()
        }, failure: { error in
            ANLogger.error(error)
        })
    }
    
    
}
