//
//  ViewController.swift
//  MovieApp
//
//  Created by Adrián Cortez Hernández on 28/06/21.
//

import UIKit

class PopularViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
        
    private var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let resultsController = SearchResultsController()
        resultsController.products = self.products
        searchController =     UISearchController(searchResultsController: resultsController)
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Enter a food name"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController*/
        
        
        // Do any additional setup after loading the view.
        loadPopularMoviesData()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
                
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search movies..."
        searchController.dimsBackgroundDuringPresentation = false

        
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchMoviesData(endpoint: "popular") { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    
    
    
}

// MARK: - TableView
extension PopularViewController: UITableViewDataSource {
    
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

extension PopularViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                                
                let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
                
                print("\(cell.movieId!) - \(cell.movieTitle!.text!)")
                
                let destinationVC = segue.destination as! DetailsViewController
                destinationVC.movieId = cell.movieId
                destinationVC.vMovieTitle  = cell.movieTitle!.text!
                destinationVC.vMovieRate = cell.movieRate.text
                destinationVC.vMovieReleaseDate = cell.movieYear.text
                destinationVC.vMovieGenre = "Action, Comedy"
                destinationVC.vMovieOverview = cell.movieOverview.text
                
                searchController.searchBar.text = ""
                searchController.dismiss(animated: true, completion: nil)

                
            }
            
        }
    }
    
}

extension PopularViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            self.viewModel.filterContentFor(textToSearch: searchText)
            self.tableView.reloadData()
        }
        
    }
    
}
