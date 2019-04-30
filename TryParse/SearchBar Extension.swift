//
//  SearchBar extension.swift
//  TryParse
//
//  Created by kino on 28/04/2019.
//  Copyright © 2019 Rafa Cosin. All rights reserved.
//

import UIKit

extension MainTableViewController: UISearchBarDelegate{
    
    func initSearchBar() {
        searchBar.delegate = self
        searchBar.isHidden = false
        searchBar.placeholder = "Search film"
        navigationItem.titleView = searchBar
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchBarActive = true
        self.filterMovies.removeAll()
        if searchText != ""  {
            let search = searchText
            filterMovies = movie.filter{ $0.title.contains(search) }
            
        }
        if filterMovies.count == 0  {
            searchBarActive = false
            if searchText != "" {
                searchBar.text = ""
                searchBar.resignFirstResponder()

            let alert = UIAlertController(title: "No matches found", message: "No results for search title", preferredStyle: .alert)
            let action =  UIAlertAction(title: "OK", style: .cancel, handler:nil)
            alert.addAction(action)
            self.present(alert,animated: true, completion: nil)
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarActive = true
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.filterMovies.removeAll()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarActive = false
        searchBar.resignFirstResponder()

    }

}
