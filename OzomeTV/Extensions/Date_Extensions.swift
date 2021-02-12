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
}
