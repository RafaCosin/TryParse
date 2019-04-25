//
//  ViewController.swift
//  TryParse
//
//  Created by kino on 25/04/2019.
//  Copyright © 2019 Rafa Cosin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var movie = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        for mov in movie {
            print(mov)
        }
    }

    func getJSON() {
    
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7a312711d0d45c9da658b9206f3851dd&language=en-US&page=1")
    
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                
                let decoder = JSONDecoder()
                let user = try! decoder.decode(MovieResults.self, from: data)
//                for i in 0...user.results.count - 1 {
//                    print(user.results[i].title)
//                    self.movie.append(user.results[i])
//                }
                   self.movie = user.results
                   print(self.movie.count)
                
                
            } catch  {
                print("Error" )
            }
        }
        task.resume()

    }
    

}

