//
//  ITAnimator.swift
//  SwiftMessages
//
//  Created by Timothy Moose on 6/4/17.
//  Copyright © 2017 SwiftKick Mobile. All rights reserved.
//

import UIKit

public typealias ITAnimationCompletion = (_ completed: Bool) -> Void

public protocol ITAnimationDelegate: class {
    func hide(animator: ITAnimator)
    func panStarted(animator: ITAnimator)
    func panEnded(animator: ITAnimator)
}

/**
 An option set representing the known types of safe area conflicts
 that could require margin adustments on the message view in order to
 get the layouts to look right.
 */
public struct ITSafeZoneConflicts: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// Message view behind status bar
    public static let statusBar = ITSafeZoneConflicts(rawValue: 1 << 0)

    /// Message view behind the sensor notch on iPhone X
    public static let sensorNotch = ITSafeZoneConflicts(rawValue: 1 << 1)

    /// Message view behind home indicator on iPhone X
    public static let homeIndicator = ITSafeZoneConflicts(rawValue: 1 << 2)

    /// Message view is over the status bar on an iPhone 8 or lower. This is a special
    /// case because we logically expect the top safe area to be zero, but it is reported as 20
    /// (which seems like an iOS bug). We use the `overStatusBar` to indicate this special case.
    public static let overStatusBar = ITSafeZoneConflicts(rawValue: 1 << 3)
}

public class ITAnimationContext {

    public let messageView: UIView
    public let containerView: UIView
    public let safeZoneConflicts: ITSafeZoneConflicts
    public let interactiveHide: Bool

    init(messageView: UIView, containerView: UIView, safeZoneConflicts: ITSafeZoneConflicts, interactiveHide: Bool) {
        self.messageView = messageView
        self.containerView = containerView
        self.safeZoneConflicts = safeZoneConflicts
        self.interactiveHide = interactiveHide
    }
}

public protocol ITAnimator: class {

    /// Adopting classes should declare as `weak`.
    var delegate: ITAnimationDelegate? { get set }

    func show(context: ITAnimationContext, completion: @escaping ITAnimationCompletion)

    func hide(context: ITAnimationContext, completion: @escaping ITAnimationCompletion)

    /// The show animation duration. If the animation duration is unknown, such as if using `UIDynamnicAnimator`,
    /// then profide an estimate. This value is used by `SwiftMessagesSegue`.
    var showDuration: TimeInterval { get }

    /// The hide animation duration. If the animation duration is unknown, such as if using `UIDynamnicAnimator`,
    /// then profide an estimate. This value is used by `SwiftMessagesSegue`.
    var hideDuration: TimeInterval { get }
}

