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
    
    func fetchShowsFromGuide(completionHandler: @escaping ([Show]?, Error?) -> Void) {
        AF.request("http://api.tvmaze.com/schedule?country=US&date=2021-02-12").responseJSON { (response) in
            
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
    
    

}
