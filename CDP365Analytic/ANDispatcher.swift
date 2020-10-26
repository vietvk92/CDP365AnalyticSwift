//
//  ANDispatcher.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

protocol ANDispatcher {
    func send(event: ANEvent, success: @escaping ()->(), failure: @escaping (_ error: Error)->())
}
