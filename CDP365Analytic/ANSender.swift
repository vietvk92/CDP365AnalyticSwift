//
//  ANSender.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

class ANSender: ANDispatcher {
    
    private let session: URLSession
    private let timeout: TimeInterval
    private let configure: ANConfigure?
    
    init(configure: ANConfiguration, timeout: TimeInterval = 5.0) {
        self.timeout = timeout
        self.session = URLSession.shared
        self.configure = configure.value
    }
    
    func send(event: ANEvent, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        
    }
}
