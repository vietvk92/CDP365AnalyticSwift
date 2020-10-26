//
//  ITAccessibleMessage.swift
//  SwiftMessages
//
//  Created by Timothy Moose on 3/11/17.
//  Copyright © 2017 SwiftKick Mobile. All rights reserved.
//

import Foundation

/**
 Message views that `ITAccessibleMessage`, as `ITMessageView` does will
 have proper accessibility behavior when displaying messages.
 `ITMessageView` implements this protocol.
 */
public protocol ITAccessibleMessage {
    var accessibilityMessage: String? { get }
    var accessibilityElement: NSObject? { get }
    var additonalAccessibilityElements: [NSObject]? { get }
}
