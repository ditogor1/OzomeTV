//
//  String_Extensions.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import Foundation
import UIKit

extension String {
    
    var toDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let date = formatter.date(from: self) else {
            return nil
        }
        return date
    }
    
    func htmlAttributedString<T>(_ applying: Dictionary<NSAttributedString.Key, T>? = nil) -> NSAttributedString? {
        guard self.isEmpty == false else { return nil }
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attributedString = try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
            
            guard let extraAttributes = applying else {
                return attributedString
            }
            
            var attributes = attributedString.attributes(at: 0, effectiveRange: nil)
            for newAttibute in extraAttributes {
                attributes[newAttibute.key] = newAttibute.value
            }
            
            attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 15)
            attributes[NSAttributedString.Key.foregroundColor] = UIColor.secondaryLabel
            return NSAttributedString(string: attributedString.string, attributes: attributes)
        } catch {
            return nil
        }
    }
    
    func applyAttributedString<T>(_ key: NSAttributedString.Key, value: T) -> NSAttributedString {
        let applyAttribute = [ key: T.self ]
        let attrString = NSAttributedString(string: self, attributes: applyAttribute)
        return attrString
    }
}
