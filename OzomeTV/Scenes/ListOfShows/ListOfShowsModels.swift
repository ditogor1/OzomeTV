//
//  AppDelegate.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

enum ListOfShows
{
    // MARK: Use cases
    
    enum FetchShows {
        
        struct Request {
            
        }
        
        struct Response {
            var shows: [Show]
        }
        
        struct ViewModel {
            struct DisplayedShow {
                let id: Int
                let url: URL?
                let name: String
                let airdate: String
                let airtime: String
                let airTimestamp: Date
                let runtime: Int
                let imageURL: URL?
                let summary: String
            }
            
            var displayedShows: [DisplayedShow]
        }
    }
}
