//
//  MovieModel.swift
//  MovieAPP
//
//  Created by ahmed on 10/01/2023.
//

import Foundation
import UIKit


class MovieModel {
    var movieTitle : String?
    var movieDescription : String?
    var releaseYear : Int?
    var genre : [String]?
    var rating : Float?
    var movieImage : UIImage?

    init(movieTitle: String? = nil, movieDescription: String? = nil, releaseYear: Int? = nil, genre: [String]? = nil, rating: Float? = nil, movieImage: UIImage? = nil) {
        self.movieTitle = movieTitle
        self.movieDescription = movieDescription
        self.releaseYear = releaseYear
        self.genre = genre
        self.rating = rating
        self.movieImage = movieImage
    }
    
    
}
