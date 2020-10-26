//
//  ITError.swift
//  SwiftMessages
//
//  Created by Timothy Moose on 8/7/16.
//  Copyright © 2016 SwiftKick Mobile LLC. All rights reserved.
//

import Foundation

/**
 The `SwiftMessagesError` enum contains the errors thrown by SwiftMessages.
 */
enum ITSwiftMessagesError: Error {
    case cannotLoadViewFromNib(nibName: String)
    case noRootViewController
}
