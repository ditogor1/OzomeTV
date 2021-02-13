//
//  Date_Extensions.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/12/21.
//

import Foundation

extension Date {
    func add(minutes: Int) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .minute, value: minutes, to: self, options: [])!
    }
    
    var dashFormatedString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    var hour: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH a"
        return formatter.string(from: self)
    }
}
