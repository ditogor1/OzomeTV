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
                      let runtime = dictionary["runtime"] as? Int,
                      let showDictionary = dictionary["show"] as? Dictionary<String, Any>,
                      let showId = showDictionary["id"] as? Int else {
                    
                    continue
                }
                
                guard let validDate = airstamp.toDate else {
                    continue
                }
                
                let summary = dictionary["summary"] as? String ?? ""
                
                var url: URL?
                if let imageDictionary = showDictionary["image"] as? Dictionary<String, Any>,
                   let urlString = imageDictionary["medium"] as? String,
                   let validUrl = URL(string: urlString) {
                    url = validUrl
                }
                
                let show = Show(id: id,
                                url: nil,
                                name: name,
                                airdate: airdate,
                                airtime: airtime,
                                airTimestamp: validDate,
                                runtime: runtime,
                                imageURL: url,
                                summary: summary,
                                showId: showId)
                
                shows.append(show)
            }
        }
        return shows
    }
    
    static func parseFetchShowFromGuide(_ json: [String : Any]) -> ShowDetails? {
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String else {
            
            return nil
        }
        
        var schedule: String = "N/A"
        if let scheduleDictionary = json["schedule"] as? Dictionary<String, Any> {
            if let time = scheduleDictionary["time"] as? String {
                schedule = time
                
                if let daysArray = scheduleDictionary["days"] as? [Any], daysArray.count > 0 {
                    schedule.append("\n")
                    for dayItem in daysArray {
                        schedule.append("\(dayItem) - ")
                    }
                    schedule.removeSubrange(schedule.index(schedule.endIndex, offsetBy: -3)..<schedule.endIndex)
                }
            }
        }
            
           
        
        var network: String?
        if let networkDictionary = json["network"] as? Dictionary<String, Any>,
           let networkString = networkDictionary["name"] as? String {
            network = networkString
        }
        
        let summary = json["summary"] as? String ?? ""
        
        var url: URL?
        if let urlString = json["officialSite"] as? String,
           let validUrl = URL(string: urlString) {
            
            url = validUrl
        }
        
        var imageURL: URL?
        if let imageDictionary = json["image"] as? Dictionary<String, Any>,
           let urlString = imageDictionary["original"] as? String,
           let url = URL(string: urlString) {
            imageURL = url
        }
        
        
        let showDetails = ShowDetails(id: id,
                               url: url,
                               name: name,
                               schedule: schedule,
                               network: network,
                               imageURL: imageURL,
                               summary: summary)
        
        return showDetails
    }
}
