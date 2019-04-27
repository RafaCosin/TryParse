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
                    self.tableView.reloadData()
                }
             })
        }
}
//    func getJSON(movieCompletionHandler:  @escaping ([Movie]?,Error?) -> Void) {
//
//            let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7a312711d0d45c9da658b9206f3851dd&language=en-US&page=1")
//
//            let task = URLSession.shared.dataTask(with: url!,completionHandler: { (data, response, error) in
//
//                guard let data = data,
//                    error == nil else {
//                        print(error?.localizedDescription ?? "Response Error")
//                        return }
//                do {
//                    let decoder = JSONDecoder()
//                    let user = try decoder.decode(MovieResults.self, from: data)
//                    DispatchQueue.main.async {
//                        movieCompletionHandler(user.results, nil)
//
//                    }
//                } catch  let parseErr {
//                    print("Error" )
//                    DispatchQueue.main.async {
//                        movieCompletionHandler(nil, parseErr)
//                    }
//                }
//            })
//            task.resume()
//        }
//    }
// func imageFromServerURL(url: URL, imgcompletionHandler: @escaping (UIImage?, Error?) -> Void) {
//    //print("en funcion : \(url)")
//    let task = URLSession.shared.dataTask(with: url,completionHandler: { (data, response, error) in
//
//        if error != nil {
//            DispatchQueue.main.async {
//                imgcompletionHandler(nil,error)
//            }
//        }
//        guard let datos = data else {return}
//        DispatchQueue.main.async {
//            print("data : dispatch)")
//            let image = UIImage(data: datos)
//
//            imgcompletionHandler(image,nil)
//
//        }
//    }).resume()
//}


extension MainTableViewController {
 
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return movie.count
}


 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TryTableViewCell
    let task = movie[indexPath.row]
    cell.overviewLabel.text = task.overview
    cell.titleLabel.text = task.title
    
    //"w92", "w154", "w185", "w342", "w500", "w780", or "original"
    let imgFixed = "https://image.tmdb.org/t/p/w154"
    let imageURL = task.posterPath
    let completa = URL(string: imgFixed + imageURL)!
  
    
    imageFromServerURL(url: completa, imgcompletionHandler: {(image,error) in
        if let imagen = image {
              let pepe = imagen
            DispatchQueue.main.async {
                cell.img.image = pepe
            }
        }
    })
    return cell
 }
 
}

