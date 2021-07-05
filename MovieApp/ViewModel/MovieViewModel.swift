//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Adrián Cortez Hernández on 28/06/21.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService()
    
    private var allMovies = [Movie]()
    private var filteredMovies = [Movie]()
    private var movieVideo = [MovieVideo]()
    
    func fetchMoviesData(endpoint: String, completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        
        apiService.getMoviesData(endpoint: endpoint) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.allMovies = listOf.movies
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int, isSearching: Bool) -> Int {
        
        if isSearching {
            if filteredMovies.count != 0 {
                return filteredMovies.count
            }
        } else {
            if allMovies.count != 0 {
                return allMovies.count
            }
        }
        
        return 0
        
    }
    
    func cellForRowAt (indexPath: IndexPath, isSearching: Bool) -> Movie {
        
        if isSearching {
            return filteredMovies[indexPath.row]
        } else {
            return allMovies[indexPath.row]
        }
        
    }
    
    func filterContentFor(textToSearch: String) {
        
        self.filteredMovies = self.allMovies.filter { movie in
            let nameToFind = movie.title!.range(of: textToSearch, options: NSString.CompareOptions.caseInsensitive)
            return nameToFind != nil
        }
        
    }
    
}
