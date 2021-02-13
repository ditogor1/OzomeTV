//
//  ShowDetailsPresenter.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ShowDetailsPresentationLogic {
    func presentShowDetails(response: ShowDetail.FetchShow.Response)
    func presentError(_ error: Error)
}

class ShowDetailsPresenter: NSObject {
    weak var viewController: (ShowDetailsDisplayLogic & DisplayLogicError)?
}

extension ShowDetailsPresenter: ShowDetailsPresentationLogic {
    func presentShowDetails(response: ShowDetail.FetchShow.Response) {
        let displayedShowDetail = ShowDetail.FetchShow.ViewModel.DisplayedShowDetail(
            id: response.showDetails.id,
            url: response.showDetails.url,
            name: response.showDetails.name,
            schedule: response.showDetails.schedule,
            network: response.showDetails.network,
            imageURL: response.showDetails.imageURL,
            summary: response.showDetails.summary)
            
        let viewModel = ShowDetail.FetchShow.ViewModel(displayedShowDetail: displayedShowDetail)
        
        viewController?.displayShowDetails(viewModel: viewModel)
    }
    
    func presentError(_ error: Error) {
        viewController?.displayErrorAlert(error)
    }
}

