//
//  Model.swift
//  MovieApp
//
//  Created by Adrián Cortez Hernández on 28/06/21.
//

import Foundation

struct MoviesData: Decodable {
    
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
}

struct Movie: Decodable {
    
    let id: Int?
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}

struct MoviesVideosData: Decodable {
    
    let movieVideo: [MovieVideo]
    
    private enum CodingKeys: String, CodingKey {
        case movieVideo = "results"
    }
    
}

struct MovieVideo: Decodable {
    
    let videoURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case videoURL = "key"
    }
}
