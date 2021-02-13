//
//  ListOfShowsWorker.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import Foundation


protocol ShowsGuideProtocol {
    func fetchShowsFromGuide(date: Date, completionHandler: @escaping ([Show]?, Error?) -> Void)
    func fetchShowDetailsFromGuide(show: Show, completionHandler: @escaping (ShowDetails?, Error?) -> Void)
}

class ListOfShowsWorker {
    
    var showsGuide: ShowsGuideProtocol
    
    init(showsGuide: ShowsGuideProtocol) {
        self.showsGuide = showsGuide
    }
    
    func fetchShowsWork(date: Date, completionHandler: @escaping ([Show]?, Error?) -> Void) {
        showsGuide.fetchShowsFromGuide(date: date, completionHandler: { (shows, error) in
            completionHandler(shows, error)
        })
    }
}



