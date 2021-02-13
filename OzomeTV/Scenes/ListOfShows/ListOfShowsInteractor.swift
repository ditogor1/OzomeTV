//
//  ListOfShowsInteractor.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ListOfShowsBusinessLogic {
    func fetchShowsRule(request: ListOfShows.FetchShows.Request)
}

protocol ListOfShowsDataSource {
    var showsDataSource: [Show]? { get }
}

class ListOfShowsInteractor: NSObject {
    var presenter: ListOfShowsPresentationLogic?
    var listOfShowsWorker = ListOfShowsWorker(showsGuide: ShowsGuideAPI())
    
    private let router = ListOfShowsRouter()
    private var shows: [Show]?
}

extension ListOfShowsInteractor: ListOfShowsBusinessLogic {
    
    func fetchShowsRule(request: ListOfShows.FetchShows.Request) {
        listOfShowsWorker.fetchShowsWork(date: request.date) { (shows, error) in
            guard error == nil else {
                self.presenter?.presentError(error!)
                return
            }
            
            guard let validShows = shows else {
                self.presenter?.presentError(GlobalError.unknown)
                return
            }
            
            self.shows = self.getCurrentAiringShows(validShows)
            let response = ListOfShows.FetchShows.Response(shows: self.shows!)
            self.presenter?.presentShows(response: response)
        }
    }
    
    private func getCurrentAiringShows(_ rawShows: [Show]) -> [Show]{
        let currentTime = Date()//"2021-02-12T20:15:00+00:00".toDate!
        
        let filteredShows = rawShows.filter { (showItem) -> Bool in
            return (currentTime >= showItem.airTimestamp) && (currentTime <= showItem.airTimestamp.add(minutes: showItem.runtime))
        }
        
        let sortedByDate = filteredShows.sorted { (displayedShowItemOne, displayedShowItemTwo) -> Bool in
            displayedShowItemOne.airTimestamp < displayedShowItemTwo.airTimestamp
        }
        
        return sortedByDate
    }
    
}

extension ListOfShowsInteractor: ListOfShowsDataSource {
    var showsDataSource: [Show]? {
        return shows
    }
}
