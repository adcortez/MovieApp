//
//  UpcomingViewController.swift
//  MovieApp
//
//  Created by Adrián Cortez Hernández on 29/06/21.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadTopRatedMoviesData()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search movies..."
        searchController.dimsBackgroundDuringPresentation = false

        
    }
    
    private func loadTopRatedMoviesData() {
        viewModel.fetchMoviesData(endpoint: "upcoming") { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView
extension UpcomingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.isActive {
            return viewModel.numberOfRowsInSection(section: section, isSearching: true)
        } else {
            return viewModel.numberOfRowsInSection(section: section, isSearching: false)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        
        if self.searchController.isActive {
            
            let movie = viewModel.cellForRowAt(indexPath: indexPath, isSearching: true)
            cell.setCellWithValuesOf(movie)
            
        } else {
            
            let movie = viewModel.cellForRowAt(indexPath: indexPath, isSearching: false)
            cell.setCellWithValuesOf(movie)
        
        }
        
        return cell
    }
    
}

extension UpcomingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
                print(cell.movieTitle!.text!)
                
                let destinationVC = segue.destination as! DetailsViewController
                destinationVC.movieId = cell.movieId
                destinationVC.vMovieTitle  = cell.movieTitle!.text!
                destinationVC.vMovieReleaseDate = cell.movieYear.text
                destinationVC.vMovieGenre = "Action, Comedy"
                destinationVC.vMovieOverview = cell.movieOverview.text
                
                searchController.searchBar.text = ""
                searchController.dismiss(animated: true, completion: nil)
                
            }
            
        }
    }
}

extension UpcomingViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.viewModel.filterContentFor(textToSearch: searchText)
            self.tableView.reloadData()
        }
    }
    
    
}
