//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Adrián Cortez Hernández on 29/06/21.
//

import UIKit
import youtube_ios_player_helper

class DetailsViewController: UIViewController {
    
    @IBOutlet var playerView: YTPlayerView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    private var apiService = ApiService()
    
    var movieId: Int?
    var vMovieTitle: String?
    var vMovieReleaseDate: String?
    var vMovieRate: String?
    var vMovieGenre: String?
    var vMovieOverview: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        if let safeMovieId = movieId {

            fetchMoviesVideoData(movieId: safeMovieId)

        }
        
        updateUI()
        
    }
    
    func updateUI() {
        
        movieTitle.text = vMovieTitle
        movieReleaseDate.text = vMovieReleaseDate
        movieRate.text = vMovieRate
        movieGenre.text = vMovieGenre
        movieOverview.text = vMovieOverview
        
    }
    
    func fetchMoviesVideoData(movieId: Int) {
        
        // weak self - prevent retain cycles
        
        apiService.getMoviesVideoData(movieId: movieId) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let videos):
                    self.playVideo(with: videos.movieVideo)
                case .failure(let error):
                    // Something is wrong with the JSON file or the model
                    print("Error processing json data: \(error)")
            }
            
        }
    }
    
    func playVideo(with videos: [MovieVideo]) {
        
        if videos.count == 0 {
            return
        } else {
            
            guard let safeVideo = videos[0].videoURL else {
                fatalError()
            }
            
            print(safeVideo)
            
            playerView.load(withVideoId: safeVideo)
            
        }
        
    }

}
