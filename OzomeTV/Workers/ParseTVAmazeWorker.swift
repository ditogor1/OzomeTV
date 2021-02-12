//
//  ParseTVAmazeWorker.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

class ParseTVAmazeWorker: NSObject {

    static func parseFetchFromGuide(_ json: [Any]) -> [Show]? {
        var shows: [Show] = []
        for anyTemp in json {
            if let dictionary = anyTemp as? Dictionary<String, Any> {
                
                guard let id = dictionary["id"] as? Int,
                      let name = dictionary["name"] as? String,
                      let airdate = dictionary["airdate"] as? String,
                      let airtime = dictionary["airtime"] as? String,
                      let airstamp = dictionary["airstamp"] as? String,
                      let runtime = dictionary["runtime"] as? Int else {
                    
                    continue
                }
                
                guard let validDate = airstamp.toDate else {
                    NSLog("======================INVALID DATE========================")
                    continue
                }
                
                let summary = dictionary["summary"] as? String ?? ""
                
                var url: URL?
                if let subDictionary = dictionary["show"] as? Dictionary<String, Any> {
                    if let imageDictionary = subDictionary["image"] as? Dictionary<String, Any>,
                       let urlString = imageDictionary["medium"] as? String,
                       let validUrl = URL(string: urlString) {
                        url = validUrl
                    }
                }
                
                let show = Show(id: id,
                                url: nil,
                                name: name,
                                airdate: airdate,
                                airtime: airtime,
                                airTimestamp: validDate,
                                runtime: runtime,
                                imageURL: url,
                                summary: summary)
                
                shows.append(show)
            }
        }
        return shows
    }
}
