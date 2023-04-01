//
//  Networking.swift
//  MovieAPP
//
//  Created by ahmed on 16/01/2023.
//

import Foundation

func fetchMovieData(compilationHandler: @escaping (MovieResponse?) -> Void){
    let url = URL(string: "https://imdb-api.com/en/API/BoxOffice/k_9smaww37")
    
    let urlRequest = URLRequest(url: url!)
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
        
        guard let newData = data else
        {
            compilationHandler (nil)
            return
        }
        do{
            let callResult = try JSONDecoder().decode(MovieResponse.self, from: newData)
            compilationHandler(callResult)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    task.resume()
}
