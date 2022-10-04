//
//  APIManager.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 04.10.2022.
//

import Foundation

private enum APIError: Error{
    case FailedToGetData
}

final class APIManager{
    
    static let shared = APIManager()
    
    private let mainUrl = "https://imdb-api.com/en/API/"
    private let apiKey = "k_16raxqmh"
    
    private init(){}
    
    func getMostPopularMovies(completionHandler: @escaping(Result<[Video], Error>)->Void){
        let stringUrl = "\(mainUrl)MostPopularMovies/\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if error != nil {
                return
            }
            
            guard let data = data else { return}
            do{
                let results = try JSONDecoder().decode(CategoryResponse.self, from: data)
                completionHandler(.success(results.items))
            }
            catch{
                completionHandler(.failure(APIError.FailedToGetData))
            }
        }
    }
    
    func getMostPopularTVs(completionHandler: @escaping(Result<[Video], Error>)->Void){
        let stringUrl = "\(mainUrl)MostPopularTVs/\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if error != nil {
                return
            }
            
            guard let data = data else { return}
            do{
                let results = try JSONDecoder().decode(CategoryResponse.self, from: data)
                completionHandler(.success(results.items))
            }
            catch{
                completionHandler(.failure(APIError.FailedToGetData))
            }
        }
    }
    
    func getInTheatres(completionHandler: @escaping(Result<[Video], Error>)->Void){
        let stringUrl = "\(mainUrl)InTheaters/\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if error != nil {
                return
            }
            
            guard let data = data else { return}
            do{
                let results = try JSONDecoder().decode(CategoryResponse.self, from: data)
                completionHandler(.success(results.items))
            }
            catch{
                completionHandler(.failure(APIError.FailedToGetData))
            }
        }
    }
    
}


