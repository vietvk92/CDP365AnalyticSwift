//
//  ANCampaign.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

struct ANCampaign: Codable {
    let campaignId: String
    let contentBlockId: String
    let timeDelay: Int
    let elementId: String
    let content: String
    let css: String
    let javascript: String
    let closeButton: Bool
    let positionId: String
}
