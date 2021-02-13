//
//  ShowDetail.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import Foundation

//typealias VMDisplayedShow = ShowDetail.GetShow.Request.Response.ViewModel.DisplayedShow

enum ShowDetail {

    enum FetchShow {
        
        struct Request {
        }
        
        struct Response {
            var showDetails: ShowDetails
        }
        
        struct ViewModel {
            struct DisplayedShowDetail {
                let id: Int
                let url: URL?
                let name: String
                let schedule: String
                let network: String?
                let imageURL: URL?
                let summary: String
            }
            
            var displayedShowDetail: DisplayedShowDetail
        }
    }
}
