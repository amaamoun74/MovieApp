//
//  MovieResponse.swift
//  MovieAPP
//
//  Created by ahmed on 16/01/2023.
//

import Foundation
class MovieResponse :Decodable{
    var items:[MovieData]?
    var errorMessage:String?
}
