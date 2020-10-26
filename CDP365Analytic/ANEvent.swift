//
//  ANEvent.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

struct ANEvent {
    let screenName: String
    let categoryName: String
    let actionName: String
    let items: [NSDictionary]?
    let extra: NSDictionary?
    let dimension: [NSDictionary]?
}

extension ANEvent {
    public init(screenName: String? = "",
                categoryName: String? = "",
                actionName: String? = "",
                items: [NSDictionary]? = [],
                extra: NSDictionary? = nil,
                dimension: [NSDictionary]? = [] ) {
        self.screenName = screenName ?? ""
        self.categoryName = categoryName ?? ""
        self.actionName = actionName ?? ""
        self.items = items
        self.extra = extra
        self.dimension = dimension
    }
}
