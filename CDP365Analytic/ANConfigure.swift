//
//  ANConfigure.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

public struct ANConfigure: Codable {
    
    let IsLogDelivery: Bool
    let DeliveryURL: String
    let AnalyticsURL: String
    let PortalID: String
    let PropertyID: String
    let Identify: Identify
}

struct Identify: Codable {
    let IdentifyID: Customer
    let CustomerFields: [Customer]
}

struct Customer: Codable {
    let field: String
    let hash_md5: Bool
}
