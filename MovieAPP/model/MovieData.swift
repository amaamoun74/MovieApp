//
//  MovieData.swift
//  MovieAPP
//
//  Created by ahmed on 16/01/2023.
//

import Foundation
// decodable protocol to get data
// encodable protocol to post data
class MovieData: Decodable,Equatable {
    static func == (lhs: MovieData, rhs: MovieData) -> Bool {
        if(lhs == rhs){
            return true
        }
        else{
            return false
        }
     //   return true
    }
    
    var id:String?
    var rank: String?
    var title: String?
    var image : String?
    var weekend: String?
    var gross:String?
    var weeks: String?
    
    init() {
        
    }
    init(id: String? = nil, rank: String? = nil, title: String? = nil, image: String? = nil, weekend: String? = nil, gross: String? = nil, weeks: String? = nil) {
        self.id = id
        self.rank = rank
        self.title = title
        self.image = image
        self.weekend = weekend
        self.gross = gross
        self.weeks = weeks
    }
}
