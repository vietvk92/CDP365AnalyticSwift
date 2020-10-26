//
//  ITIdentifiable.swift
//  SwiftMessages
//
//  Created by Timothy Moose on 8/1/16.
//  Copyright © 2016 SwiftKick Mobile LLC. All rights reserved.
//

import Foundation

/**
 Message views that adopt the `ITIdentifiable` protocol will have duplicate messages
 removed from the `ITMessageView` queue. Typically, the `id` would be set to a string
 representation of the content of the message view. For example, `ITMessageView`, combines
 the title and message body text.
 
 This protocol is optional. Messave views that don't adopt `ITIdentifiable` will not
 have duplicates removed.
 */
public protocol ITIdentifiable {
    var id: String { get }
}
