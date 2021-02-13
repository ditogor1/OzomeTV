//
//  ShowDetailsInteractor.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ShowDetailsBusinessLogic {
    func fetchShowDetails()
}

protocol ShowDetailsDataSource {
    var showDetailataSource: ShowDetails! { get }
    var showDataSource: Show! { get set }
}

class ShowDetailsInteractor: NSObject {
    var presenter: ShowDetailsPresentationLogic?
    var show: Show!
    var listOfShowsWorker = ShowDetailsWorker(showsGuide: ShowsGuideAPI())
    var showDetails: ShowDetails?
}

extension ShowDetailsInteractor: ShowDetailsBusinessLogic {

    func fetchShowDetails() {
        guard let _ = show else {
            self.presenter?.presentError(GlobalError.unknown)
            return
        }
        
        listOfShowsWorker.fetchShowDetailsWork(show: showDataSource) { (showDetails, error) in
            guard error == nil else {
                self.presenter?.presentError(error!)
                return
            }

            guard let validShowDetails = showDetails else {
                self.presenter?.presentError(GlobalError.unknown)
                return
            }

            self.showDetails = validShowDetails
            let response = ShowDetail.FetchShow.Response(showDetails: validShowDetails)
            self.presenter?.presentShowDetails(response: response)
        }
    }
}

extension ShowDetailsInteractor: ShowDetailsDataSource {
    var showDetailataSource: ShowDetails! {
        get {
            return showDetails
        }
    }

    var showDataSource: Show! {
        get {
            return show
        }

        set {
            show = newValue
        }
    }
}
