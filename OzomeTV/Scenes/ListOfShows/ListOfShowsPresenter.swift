//
//  AppDelegate.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ListOfShowsPresentationLogic: class {
    func presentShows(response: ListOfShows.FetchShows.Response)
    func presentError(_ error: Error)
}

class ListOfShowsPresenter: ListOfShowsPresentationLogic {
    
    weak var viewController: (ListOfShowsDisplayLogic & DisplayLogicError)?
    
    // MARK: ListOfShowsDisplayLogic
    
    func presentShows(response: ListOfShows.FetchShows.Response) {
//        var displayedShows: [ListOfShows.FetchShows.ViewModel.DisplayedShow] = []
//        for show in response.shows {
//            let displayedShow = ListOfShows.FetchShows.ViewModel.DisplayedShow(
//                id: show.id, url: show.url, name: show.name, airdate: show.airdate, airtime: show.airtime, airTimestamp: show.airTimestamp, imageURL: show.imageURL, summary: show.summary)
//            displayedShows.append(displayedShow)
//        }
//
//        let viewModel = ListOfShows.FetchShows.ViewModel(displayedShows: displayedShows)
        
        let viewModel = getCurrentAiringShows(response: response)
        viewController?.displayFetchedShows(viewModel: viewModel)
    }
    
    // MARK: DisplayLogicError
    
    func presentError(_ error: Error) {
        viewController?.displayErrorAlert(error)
    }
    
    // MARK: Manipulate Shows
    
    private func getCurrentAiringShows(response: ListOfShows.FetchShows.Response) -> ListOfShows.FetchShows.ViewModel {
        var displayedShows: [ListOfShows.FetchShows.ViewModel.DisplayedShow] = []
        let currentTime = "2021-02-12T16:15:00+00:00".toDate! // Date()
        
        let preSortedByDate = response.shows.sorted { (displayedShowItemOne, displayedShowItemTwo) -> Bool in
            displayedShowItemOne.airTimestamp < displayedShowItemTwo.airTimestamp
        }
        
        for show in preSortedByDate {
            if (currentTime >= show.airTimestamp) && (currentTime <= show.airTimestamp.add(minutes: show.runtime)) {
                let displayedShow = ListOfShows.FetchShows.ViewModel.DisplayedShow(
                    id: show.id,
                    url: show.url,
                    name: show.name,
                    airdate: show.airdate,
                    airtime: show.airtime,
                    airTimestamp: show.airTimestamp,
                    runtime: show.runtime,
                    imageURL: show.imageURL,
                    summary: show.summary)
                displayedShows.append(displayedShow)
            }
            
        }
        
        let sortedByDate = displayedShows.sorted { (displayedShowItemOne, displayedShowItemTwo) -> Bool in
            displayedShowItemOne.airTimestamp < displayedShowItemTwo.airTimestamp
        }
        
        return ListOfShows.FetchShows.ViewModel(displayedShows: sortedByDate)
    }
}





