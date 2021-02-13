//
//  ListOfShows.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

typealias VMDisplayedShow = ListOfShows.FetchShows.ViewModel.DisplayedShow

enum ListOfShows {
    // MARK: Use cases
    
    enum FetchShows {
        
        struct Request {
            let date: Date
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
                let showId: Int
            }
            
            var displayedShows: [DisplayedShow]
        }
    }
    
    enum DisplayShowDetails {
        struct Request {
            var indexPath: IndexPath
            var navigationController: UINavigationController?
        }
        
        struct Response {
            var show: Show
        }
        
        struct ViewModel {
        }
    }
}
