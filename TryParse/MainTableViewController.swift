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
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            getJSON(movieCompletionHandler: {
                 (movie, error) in
                if let movie = movie {
                    self.movie = movie
                    
                }
            })
            
        }
//        override func viewWillAppear(_ animated: Bool) {
//             tableView.reloadData()
//        }
        
    func getJSON(movieCompletionHandler:  @escaping ([Movie]?,Error?) -> Void) {
        
            let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7a312711d0d45c9da658b9206f3851dd&language=en-US&page=1")
            
            let task = URLSession.shared.dataTask(with: url!,completionHandler: { (data, response, error) in
                guard let data = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do {
                    
                    let decoder = JSONDecoder()
                    let user = try! decoder.decode(MovieResults.self, from: data)
                    
                    //print(user.results[0].title)

                    DispatchQueue.main.async {
                        
                        movieCompletionHandler(user.results, nil)
                        self.tableView.reloadData()
                    }
                    
                } catch  let parseErr {
                    print("Error" )
                    DispatchQueue.main.async {
                        
                   
                    movieCompletionHandler(nil, parseErr)
                         }
                }
               
            })
            
            task.resume()
            
        }
    
    }

extension MainTableViewController {
 
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return movie.count
}


 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TryTableViewCell
    let task = movie[indexPath.row]
    cell.overviewLabel.text = task.title
    cell.titleLabel.text = task.title
 

 
 return cell
 }

}

