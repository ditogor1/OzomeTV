//
//  ShowsGuideAPI.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import Alamofire

enum ShowsGuideAPIError: Error {
    case extraneousObject
}

class ShowsGuideAPI: ShowsGuideProtocol {
    
    func fetchShowsFromGuide(date: Date, completionHandler: @escaping ([Show]?, Error?) -> Void) {
        let url = "http://api.tvmaze.com/schedule?country=US&date=\(date.add(minutes: -60).dashFormatedString)"
        print("url: \(url)")
        AF.request(url).responseJSON { (response) in
            
            switch response.result {
            case .success(let JSON):
                
                guard let validArray = JSON as? [Any] else {
                    completionHandler(nil, ShowsGuideAPIError.extraneousObject)
                    return
                }
                
                guard let shows: [Show] = ParseTVAmazeWorker.parseFetchFromGuide(validArray) else {
                    completionHandler(nil, ShowsGuideAPIError.extraneousObject)
                    return
                }
                
                completionHandler(shows, nil)

            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func fetchShowDetailsFromGuide(show: Show, completionHandler: @escaping (ShowDetails?, Error?) -> Void) {
        let url = "http://api.tvmaze.com/shows/\(show.showId)"
        print("url: \(url)")
        AF.request(url).responseJSON { (response) in
            
            switch response.result {
            case .success(let JSON):
                
                guard let validDictionary = JSON as? [String : Any] else {
                    completionHandler(nil, ShowsGuideAPIError.extraneousObject)
                    return
                }
                
                guard let show: ShowDetails = ParseTVAmazeWorker.parseFetchShowFromGuide(validDictionary) else {
                    completionHandler(nil, ShowsGuideAPIError.extraneousObject)
                    return
                }
                
                completionHandler(show, nil)

            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        
        
    }

}
