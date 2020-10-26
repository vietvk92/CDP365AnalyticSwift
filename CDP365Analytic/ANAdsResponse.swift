//
//  ANAdsResponse.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import UIKit
import Foundation

class ANAdsResponse: NSObject {
    
    static func processing(data: Data) {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)  as! [String:AnyObject]
            if let status = jsonData["status"] as? Bool {
                if status {
                    if let campaignsData = try? JSONSerialization.data(withJSONObject: jsonData["campaigns"]!, options: .prettyPrinted) {
                        do {
                            let campaigns = try JSONDecoder().decode([ANCampaign].self, from: campaignsData)
                            if campaigns.count > 0 {
                                ANAdsResponse.showAds(campaign: campaigns[0])
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        } catch {
            print("JSON Processing Failed")
        }
    }
    
    
    fileprivate static func showAds(campaign: ANCampaign) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(campaign.timeDelay)) {
            switch UIApplication.shared.applicationState {
            case .background, .inactive:
                break
            case .active:
                
                let view = ITMessageView.viewFromNib(layout: .cardView)
                view.configureContent(campaign: campaign) { (_) in
                    ITSwiftMessages.hide()
                }
                view.onTappedDirectLink {
                    ITSwiftMessages.hide()
                }
                
                view.configureDropShadow()
                var config = ITSwiftMessages.defaultConfig
                switch campaign.positionId {
                case "full_screen":
                    config.presentationStyle = .fullscreen
                case "top":
                    config.presentationStyle = .top
                case "bottom":
                    config.presentationStyle = .bottom
                case "center":
                    config.presentationStyle = .center
                default:
                    config.presentationStyle = .top
                }
                
                config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
                config.duration = .forever
                config.interactiveHide = true
                ITSwiftMessages.show(config: config, view: view)
                
            default:
                break
            }
        }
    }

}
