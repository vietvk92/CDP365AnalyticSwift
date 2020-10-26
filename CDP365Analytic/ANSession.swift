//
//  ANSession.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

class ANSession {
    
    fileprivate static var _session: String?
    private(set) static var sessionID: String {
        get {
            return _session ?? ""
        }
        set(newValue) {
            return _session = newValue
        }
    }
    
    static func startNewSession() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMddHHmm"
        _session = formatter.string(from: Date())
        
        Timer.scheduledTimer(withTimeInterval: 1800, repeats: true, block: { timer in
            _session = formatter.string(from: Date())
        })
    }
}
