//
//  ITWindowViewController.swift
//  SwiftMessages
//
//  Created by Timothy Moose on 8/1/16.
//  Copyright © 2016 SwiftKick Mobile LLC. All rights reserved.
//

import UIKit

open class ITWindowViewController: UIViewController
{
    fileprivate var window: UIWindow?
    
    let windowLevel: UIWindow.Level
    let config: ITSwiftMessages.ITConfig
    
    override open var shouldAutorotate: Bool {
        return config.shouldAutorotate
    }
    
    public init(windowLevel: UIWindow.Level?, config: ITSwiftMessages.ITConfig) {
        self.windowLevel = windowLevel ?? UIWindow.Level.normal //UIWindow.Level.normal
        self.config = config
        let view = ITPassthroughView()
        let window = ITPassthroughWindow(hitTestView: view)
        self.window = window
        super.init(nibName: nil, bundle: nil)
        self.view = view
        window.rootViewController = self
        window.windowLevel = windowLevel ?? UIWindow.Level.normal
        if #available(iOS 13, *) {
            window.overrideUserInterfaceStyle = config.overrideUserInterfaceStyle
        }
    }
    
    func install(becomeKey: Bool) {
        show(becomeKey: becomeKey)
    }

    @available(iOS 13, *)
    func install(becomeKey: Bool, scene: UIWindowScene?) {
        window?.windowScene = scene
        show(becomeKey: becomeKey, frame: scene?.coordinateSpace.bounds)
    }
    
    private func show(becomeKey: Bool, frame: CGRect? = nil) {
        guard let window = window else { return }
        window.frame = frame ?? UIScreen.main.bounds
        if becomeKey {
            window.makeKeyAndVisible()
        } else {
            window.isHidden = false
        }
    }
    
    func uninstall() {
        window?.isHidden = true
        window = nil
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return config.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }

    open override var prefersStatusBarHidden: Bool {
        return config.prefersStatusBarHidden ?? super.prefersStatusBarHidden
    }
}

extension ITWindowViewController {
    static func newInstance(windowLevel: UIWindow.Level?, config: ITSwiftMessages.ITConfig) -> ITWindowViewController {
        return config.windowViewController?(windowLevel, config) ?? ITWindowViewController(windowLevel: windowLevel, config: config)
    }
}
