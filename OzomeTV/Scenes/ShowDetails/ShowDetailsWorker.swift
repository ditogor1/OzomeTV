//
//  ShowDetailsWorker.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

class ShowDetailsWorker {
    var showsGuide: ShowsGuideProtocol
    
    init(showsGuide: ShowsGuideProtocol) {
        self.showsGuide = showsGuide
    }
    
    func fetchShowDetailsWork(show: Show, completionHandler: @escaping (ShowDetails?, Error?) -> Void) {
        showsGuide.fetchShowDetailsFromGuide(show: show) { (show, error) in
            completionHandler(show, error)
        }
    }
}
