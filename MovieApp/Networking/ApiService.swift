//
//  ApiService.swift
//  MovieApp
//
//  Created by Adrián Cortez Hernández on 28/06/21.
//

import Foundation

class ApiService {
    
    
    private var dataTask: URLSessionDataTask?
    private let apiKey = "61895d3fdd47d3ebda32ee2680177b01"
    private let baseURL = "https://api.themoviedb.org/3"
    
    func getMoviesData(endpoint: String, completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let popularMoviesURL = "\(baseURL)/movie/\(endpoint)?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: popularMoviesURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                print(data)
                
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    
    func getMoviesVideoData(movieId: Int, completion: @escaping (Result<MoviesVideosData, Error>) -> Void) {
  
        let movieVideoURL = "\(baseURL)/movie/\(movieId)/videos?api_key=\(apiKey)&language=en-US"
        
        guard let url = URL(string: movieVideoURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                print(data)
                
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesVideosData.self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
