//
//  MainTableViewController.swift
//  TryParse
//
//  Created by kino on 25/04/2019.
//  Copyright © 2019 Rafa Cosin. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
     var movie = [Movie]()
     var filterMovies = [Movie]()
     var searchBarActive = false
    // let searchController = UISearchController(searchResultsController: nil)
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            initSearchBar()
            //initSearchController()
            tableView.separatorStyle = .none
            title = "Privalia Popular films"
            getJSON(movieCompletionHandler: {
                 (movie, error) in
                if let movie = movie {
                    self.movie = movie
                    self.tableView.reloadData()
                }
             })
        
        }
}

extension MainTableViewController {
 
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if  searchBarActive {
            return filterMovies.count
        } else {
            return movie.count
        }
    }

 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var task : Movie!
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TryTableViewCell
    
    print("searchBarActive \(searchBarActive)")
    if searchBarActive {
          task = filterMovies[indexPath.row]
    } else {
          task = movie[indexPath.row]
    }
    
    
    cell.overviewLabel.text = task.overview
    cell.titleLabel.text = task.title
    cell.yearLabel.text = "Year : " + task.year
    //"w92", "w154", "w185", "w342", "w500", "w780", or "original"
    let imgFixed = "https://image.tmdb.org/t/p/w154"
    let imageURL = task.posterPath
    let completa = URL(string: imgFixed + imageURL)!

    imageFromServerURL(url: completa, imgcompletionHandler: {(image,error) in
        if let imagen = image {
            
            DispatchQueue.main.async {
                cell.img.image = imagen
            }
        }
    })
   
    return cell
 }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
extension MainTableViewController: UISearchBarDelegate{
    //, UISearchResultsUpdating
    
    func initSearchBar() {
        searchBar.delegate = self
        searchBar.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarActive = true
        let pepe = searchText
        filterMovies = movie.filter{ $0.title.contains(pepe) }
        //filterMovies.forEach { print($0.title) }
        if filterMovies.count == 0 {
            searchBarActive = false
        }
        self.tableView.reloadData()
    }
//    func initSearchController() {
//
//        searchController.searchResultsUpdater = self
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.dimsBackgroundDuringPresentation = false
//        tableView.tableHeaderView = searchController.searchBar
//
//             //self.navigationItem.titleView = searchController
//
//    }
//
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBarActive = true
        self.searchBar.showsCancelButton = true
        navigationItem.hidesSearchBarWhenScrolling = false

        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchBarActive = true
        let pepe = searchController.searchBar.text!
        filterMovies = movie.filter{ $0.title.contains(pepe) }
        //filterMovies.forEach { print($0.title) }
        if filterMovies.count == 0 {
            searchBarActive = false
        }
        self.tableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarActive = false
    }
}
