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
    private let serializer = ANEventAPISerializer()
    
    init(configure: ANConfiguration, timeout: TimeInterval = 5.0) {
        self.timeout = timeout
        self.session = URLSession.shared
        self.configure = configure.value
    }
    
    func send(event: ANEvent, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        if let config = configure,
            config.PortalID.count > 0,
            config.PropertyID.count > 0 {
            let jsonBody: Data
            do {
                jsonBody = try serializer.json(forEvent: event)
            } catch  {
                failure(error)
                return
            }
            let requestAnalytic = buildRequest(baseURL: config.AnalyticsURL, portalId: config.PortalID, propertyId: config.PropertyID, method: "POST", contentType: "application/json; charset=utf-8", body: jsonBody)
            send(request: requestAnalytic, success: success, failure: failure)
            if config.IsLogDelivery {
                let requestDelivery = buildRequest(baseURL: config.DeliveryURL, portalId: config.PortalID, propertyId: config.PropertyID, method: "POST", contentType: "application/json; charset=utf-8", body: jsonBody)
                send(request: requestDelivery, success: success, failure: failure)
            }
        }else {
            failure(SDKError(msg: "Invalid configure file."))
        }
    }
    
}

extension ANSender {
    private func buildRequest(baseURL: String, portalId: String, propertyId: String, method: String, contentType: String? = nil, body: Data? = nil) -> URLRequest {
        
        let queryStringParam = [
            ANConfigurationKeys.QueryParamsPortalID: portalId,
            ANConfigurationKeys.QueryParamsPropertyID : propertyId,
            ANConfigurationKeys.QueryParamsResponseType : "json",
            ANConfigurationKeys.QueryParamsFormat : "json"
        ]
        var urlComponent = URLComponents(string: baseURL)
        let queryItem = queryStringParam.map {URLQueryItem(name: $0.key, value: $0.value)}
        urlComponent?.queryItems = queryItem
        
        var request = URLRequest(url: (urlComponent?.url!)!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: timeout)
        request.httpMethod = method
        body.map { request.httpBody = $0 }
        contentType.map { request.setValue($0, forHTTPHeaderField: "Content-Type") }
        ANUtilities.defaultUserAgent.map { request.setValue($0, forHTTPHeaderField: "User-Agent") }
        
        return request
    }
    
    private func send(request: URLRequest, success: @escaping ()->(), failure: @escaping (_ error: Error)->()) {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                failure(error)
            } else {
                guard let data = data else { return }
                ANAdsResponse.processing(data: data)
                success()
            }
        }
        task.resume()
    }
}
