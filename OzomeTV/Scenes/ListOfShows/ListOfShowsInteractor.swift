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
        presenter?.presentSpiningLoader(true)
        
        listOfShowsWorker.fetchShowsWork(date: request.date) { (shows, error) in
            self.presenter?.presentSpiningLoader(false)
            
            guard error == nil else {
                self.presenter?.presentError(error!)
                return
            }
            
            guard let validShows = shows else {
                self.presenter?.presentError(GlobalError.unknown)
                return
            }
            
            self.shows = self.getCurrentAiringShows(validShows, currentTime: request.date, atHour: request.atHour)
            let response = ListOfShows.FetchShows.Response(shows: self.shows!)
            self.presenter?.presentShows(response: response)
        }
    }
    
    private func getCurrentAiringShows(_ rawShows: [Show], currentTime: Date, atHour: Int) -> [Show]{
        let extraTime = (atHour < 0 || atHour > 24) ? 0 : (atHour * 60)
        let actualTime = currentTime.add(minutes: extraTime)
        
        var showsToDisplay: [Show]
        let filteredShows = rawShows.filter { (showItem) -> Bool in
            return (actualTime >= showItem.airTimestamp) && (actualTime <= showItem.airTimestamp.add(minutes: showItem.runtime))
        }
        
        showsToDisplay = filteredShows.count > 0 ? filteredShows : nextFewShows(rawShows)
        
        let sortedByDate = showsToDisplay.sorted { (displayedShowItemOne, displayedShowItemTwo) -> Bool in
            displayedShowItemOne.airTimestamp < displayedShowItemTwo.airTimestamp
        }
        
        return sortedByDate
    }
    
    private func nextFewShows(_ rawShows: [Show]) -> [Show] {
        let maxumber = 5
        let currentTime = Date()
        
        let filteredShows = rawShows.filter { (showItem) -> Bool in
            return currentTime >= showItem.airTimestamp
        }
        
        return Array(filteredShows.prefix(maxumber))
    }
}

extension ListOfShowsInteractor: ListOfShowsDataSource {
    var showsDataSource: [Show]? {
        return shows
    }
}
