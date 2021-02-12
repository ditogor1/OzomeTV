//
//  OTVErrors.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import Foundation

enum GlobalError: Error {
    case unknown
}

extension GlobalError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "An unknown error has occurred."
        }
    }
    
}
