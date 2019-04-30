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
     @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            initSearchBar()
     
            tableView.separatorStyle = .none
            title = "Popular films"
        
            getJSON(movieCompletionHandler: {
                 (movie, error) in
                if let movie = movie {
                    self.movie = movie
                    self.tableView.reloadData()
                }
             })
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImageView(frame: self.tableView.bounds)
        img.image = UIImage(named: "papel_bloc.png")
        self.tableView.backgroundView = img

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let target = segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                if filterMovies.count != 0 {
                    target.movie = self.filterMovies[selectedRow]
                } else {
                    target.movie = self.movie[selectedRow]
                }
             
            }
        }
    }        
}
