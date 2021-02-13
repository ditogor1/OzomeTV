//
//  ListOfShowsPresenter.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ListOfShowsPresentationLogic: class {
    func presentShows(response: ListOfShows.FetchShows.Response)
    func presentError(_ error: Error)
    func presentSpiningLoader(_ display: Bool)
}

class ListOfShowsPresenter: NSObject {
    
    weak var viewController: (ListOfShowsDisplayLogic & DisplayLogicError)?
    
    // MARK: Manipulate Shows
    
    private func mapToViewModel(response: ListOfShows.FetchShows.Response) -> ListOfShows.FetchShows.ViewModel {
        var displayedShows: [VMDisplayedShow] = []
        for show in response.shows {
            let displayedShow = VMDisplayedShow(
                id: show.id,
                url: show.url,
                name: show.name,
                airdate: show.airdate,
                airtime: show.airtime,
                airTimestamp: show.airTimestamp,
                runtime: show.runtime,
                imageURL: show.imageURL,
                summary: show.summary,
                showId: show.showId)
            
            displayedShows.append(displayedShow)
        }
        return ListOfShows.FetchShows.ViewModel(displayedShows: displayedShows)
    }
}

extension ListOfShowsPresenter: ListOfShowsPresentationLogic {
    func presentShows(response: ListOfShows.FetchShows.Response) {
        let viewModel = mapToViewModel(response: response)
        viewController?.displayFetchedShows(viewModel: viewModel)
        viewController?.displayEmptyShows(viewModel.displayedShows.count > 0)
    }
    
    func presentError(_ error: Error) {
        viewController?.displayErrorAlert(error)
    }
    
    func presentSpiningLoader(_ display: Bool) {
        viewController?.displaySpinnerLoader(display)
    }
}



