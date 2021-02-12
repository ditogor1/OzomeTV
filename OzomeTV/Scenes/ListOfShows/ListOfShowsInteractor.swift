//
//  AppDelegate.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ListOfShowsBusinessLogic {
    func fetchShowsRule(request: ListOfShows.FetchShows.Request)
}

class ListOfShowsInteractor: ListOfShowsBusinessLogic {
    var presenter: ListOfShowsPresentationLogic?
    var listOfShowsWorker = ListOfShowsWorker(showsGuide: ShowsGuideAPI())
    var shows: [Show]?
    
    // MARK: Do something
    
    func fetchShowsRule(request: ListOfShows.FetchShows.Request) {
        listOfShowsWorker.fetchShowsWork { (shows, error) in
            guard error == nil else {
                self.presenter?.presentError(error!)
                return
            }
            
            guard let validShows = shows else {
                self.presenter?.presentError(GlobalError.unknown)
                return
            }
            
            self.shows = shows
            let response = ListOfShows.FetchShows.Response(shows: validShows)
            self.presenter?.presentShows(response: response)
        }
    }
}
