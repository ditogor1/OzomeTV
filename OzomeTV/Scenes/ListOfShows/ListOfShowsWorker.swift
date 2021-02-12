//
//  AppDelegate.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import Foundation


class ListOfShowsWorker {
    
    var showsGuide: ShowsGuideProtocol
    
    init(showsGuide: ShowsGuideProtocol) {
        self.showsGuide = showsGuide
    }
    
    func fetchShowsWork(completionHandler: @escaping ([Show]?, Error?) -> Void) {
        
        showsGuide.fetchShowsFromGuide { (shows, error) in
            completionHandler(shows, error)
        }
        
    }
}


protocol ShowsGuideProtocol {
    
    func fetchShowsFromGuide(completionHandler: @escaping ([Show]?, Error?) -> Void)
}
