//
//  ValueExtension.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation
import CryptoKit

extension Int {
    func toString() -> String {
        return "\(self)"
    }
}

/// Properties for extending String object
extension String {
    
    var MD5: String {
        if #available(iOS 13.0, *) {
            let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
            return computed.map { String(format: "%02hhx", $0) }.joined()
        } else {
            return ""
        }
        
    }
    /// Returns a percent encoded string
    var percentEncodedString: String {
        let toEncodeSet = CharacterSet(charactersIn:"! #$@'()*+,/:;=?@[]\"%-.<>\\^_{}|~&").inverted
        return self.addingPercentEncoding(withAllowedCharacters: toEncodeSet)!
    }
    
    /// Returns a percent decoded sgtring
    var percentDecodedString:String {
        if let decodedString = self.removingPercentEncoding {
            return decodedString
        } else {
            return ""
        }
    }
    
    /**
     Converts a String into a NSDictionary or NSArray
     
     - returns: NSDictionary or NSArray
     */
    func toJSONObject() -> Any? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            return try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
    func toBool() -> Bool {
        return self == "True"
            || self == "true"
            || self == "yes"
            || self == "1"
    }
    
    func toInt() -> Int {
        if let i = Int(self) {
            return i
        }
        return 0
    }
    
    /**
     Removes white spaces inside of a string
     
     - returns: a string
     */
    func removeSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
}

// MARK: - AnonymousID
extension String {
    fileprivate var nextIndex: Int {
        var index = 1
        let keychain = ANKeychainSwift()
        if let stringIndex = keychain.get(ANUtilities.ANUtilitiesKey.indexAnonymousID.rawValue), stringIndex.count > 0 {
            index = (Int(stringIndex) ?? 0) + 1
        }
        return index
    }
    
    func nextID() -> String {
        return ANUtilities.identifierForAdvertising + nextIndex.toString()
    }
    
    func storageIndexAnonymous() {
        let keychain = ANKeychainSwift()
        keychain.set(nextIndex.toString(), forKey: ANUtilities.ANUtilitiesKey.indexAnonymousID.rawValue)
    }
    
}
