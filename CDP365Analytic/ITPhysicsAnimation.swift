//
//  ITPhysicsAnimation.swift
//  SwiftMessages
//
//  Created by Timothy Moose on 6/14/17.
//  Copyright © 2017 SwiftKick Mobile. All rights reserved.
//

import UIKit

public class ITPhysicsAnimation: NSObject, ITAnimator {
    
    public enum ITPlacement {
        case top
        case center
        case bottom
        case fullscreen
    }

    open var placement: ITPlacement // = .center

    open var showDuration: TimeInterval = 0.5

    open var hideDuration: TimeInterval = 0.15

    public var panHandler = ITPhysicsPanHandler()

    public weak var delegate: ITAnimationDelegate?
    weak var messageView: UIView?
    weak var containerView: UIView?
    var context: ITAnimationContext?

    public init(placement: ITPlacement) {
        self.placement = placement
    }

    init(placement: ITPlacement,delegate: ITAnimationDelegate) {
        self.placement = placement
        self.delegate = delegate
    }

    public func show(context: ITAnimationContext, completion: @escaping ITAnimationCompletion) {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustMargins), name: UIDevice.orientationDidChangeNotification, object: nil)
        install(context: context)
        showAnimation(context: context, completion: completion)
    }

    public func hide(context: ITAnimationContext, completion: @escaping ITAnimationCompletion) {
        NotificationCenter.default.removeObserver(self)
        if panHandler.isOffScreen {
            context.messageView.alpha = 0
            panHandler.state?.stop()
        }
        let view = context.messageView
        self.context = context
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            view.alpha = 1
            view.transform = CGAffineTransform.identity
            completion(true)
        }
        UIView.animate(withDuration: hideDuration, delay: 0, options: [.beginFromCurrentState, .curveEaseIn, .allowUserInteraction], animations: {
            view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
        UIView.animate(withDuration: hideDuration, delay: 0, options: [.beginFromCurrentState, .curveEaseIn, .allowUserInteraction], animations: {
            view.alpha = 0
        }, completion: nil)
        CATransaction.commit()
    }

    func install(context: ITAnimationContext) {
        let view = context.messageView
        let container = context.containerView
        messageView = view
        containerView = container
        self.context = context
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        switch placement {
        case .center:
            view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4).isActive = true
            view.centerYAnchor.constraint(equalTo: container.centerYAnchor).with(priority: UILayoutPriority(200)).isActive = true
        case .top:
            view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4).isActive = true
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: 20).with(priority: UILayoutPriority(200)).isActive = true
        case .bottom:
            view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4).isActive = true
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor).with(priority: UILayoutPriority(200)).isActive = true
        case .fullscreen:
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: 20).with(priority: UILayoutPriority(200)).isActive = true
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor).with(priority: UILayoutPriority(200)).isActive = true
        }
        NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        // Important to layout now in order to get the right safe area insets
        container.layoutIfNeeded()
        adjustMargins()
        container.layoutIfNeeded()
        installInteractive(context: context)
    }

    @objc public func adjustMargins() {
        guard let adjustable = messageView as? ITMarginAdjustable & UIView,
            let context = context else { return }
        adjustable.preservesSuperviewLayoutMargins = false
        if #available(iOS 11, *) {
            adjustable.insetsLayoutMarginsFromSafeArea = false
        }
        adjustable.layoutMargins = adjustable.defaultMarginAdjustment(context: context)
    }

    func showAnimation(context: ITAnimationContext, completion: @escaping ITAnimationCompletion) {
        let view = context.messageView
        view.alpha = 0.25
        view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion(true)
        }
        UIView.animate(withDuration: showDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.beginFromCurrentState, .curveLinear, .allowUserInteraction], animations: {
            view.transform = CGAffineTransform.identity
        }, completion: nil)
        UIView.animate(withDuration: 0.3 * showDuration, delay: 0, options: [.beginFromCurrentState, .curveLinear, .allowUserInteraction], animations: {
            view.alpha = 1
        }, completion: nil)
        CATransaction.commit()
    }

    func installInteractive(context: ITAnimationContext) {
        guard context.interactiveHide else { return }
        panHandler.configure(context: context, animator: self)
    }
}


