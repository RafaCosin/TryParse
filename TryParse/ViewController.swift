//
//  ViewController.swift
//  TryParse
//
//  Created by kino on 25/04/2019.
//  Copyright © 2019 Rafa Cosin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {


    
    var movie = [Movie]()
    var kkk = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON(movieCompletionHandler: {movie, error in
            if let peli = movie {
                self.movie = peli
            }
        })
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
     
    }

    func getJSON(movieCompletionHandler: @escaping ([Movie]?, Error?) -> Void) {
    
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7a312711d0d45c9da658b9206f3851dd&language=en-US&page=1")
    
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            
         (data, response, error) in
            guard let data = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                
                let decoder = JSONDecoder()
                let user = try! decoder.decode(MovieResults.self, from: data)
                let otro = user.results
                for i in 0...user.results.count - 1 {
                    print(user.results[i].title)
                    self.kkk.append(user.results[i])
                }
                
                   print(self.movie.count)
                   movieCompletionHandler(otro,nil)
                
                
            } catch  let parseErr {
                print("Error" )
                movieCompletionHandler(nil,parseErr)
            }
        })
        task.resume()

    }
    

}

