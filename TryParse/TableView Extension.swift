//
//  TableView Extension.swift
//  TryParse
//
//  Created by kino on 28/04/2019.
//  Copyright © 2019 Rafa Cosin. All rights reserved.
//

import UIKit

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
        
        cell.backgroundColor = UIColor.clear
        if searchBarActive && filterMovies.count > 0 {
            task = filterMovies[indexPath.row]
        } else {
            task = movie[indexPath.row]
        }
        
        
        cell.overviewLabel.text = task.overview
        cell.titleLabel.text = task.title
        cell.yearLabel.text = "Year : " + task.year
        //"w92", "w154", "w185", "w342", "w500", "w780", or "original"
        let completa = ensambleURL(size: "w154", posterPath: task.posterPath)
        
        imageFromURL(url: completa, imgcompletionHandler: {(image,error) in
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
