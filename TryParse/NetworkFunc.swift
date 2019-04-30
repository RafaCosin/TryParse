//
//  HelperFunc.swift
//  TryParse
//
//  Created by kino on 26/04/2019.
//  Copyright © 2019 Rafa Cosin. All rights reserved.
//

import UIKit

func ensambleURL(size: String,posterPath: String) -> URL {
    
    let imgFixed = "https://image.tmdb.org/t/p/"
    let imageURL = size + "/" + posterPath
    return URL(string: imgFixed + imageURL)!
}

func getJSON(movieCompletionHandler:  @escaping ([Movie]?,Error?) -> Void) {
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7a312711d0d45c9da658b9206f3851dd&language=en-US&page=1")
    
    let task = URLSession.shared.dataTask(with: url!,completionHandler: { (data, response, error) in
        
        guard let data = data,
            error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(MovieResults.self, from: data)
            DispatchQueue.main.async {
                movieCompletionHandler(user.results, nil)
                
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

func imageFromURL(url: URL, imgcompletionHandler: @escaping (UIImage?, Error?) -> Void) {
    
    let task = URLSession.shared.dataTask(with: url,completionHandler: { (data, response, error) in
        
        if error != nil {
            DispatchQueue.main.async {
                imgcompletionHandler(nil,error)
            }
        }
        guard let datos = data else {return}
        DispatchQueue.main.async {
    
            let image = UIImage(data: datos)
            
            imgcompletionHandler(image,nil)
            
        }
    })
    task.resume()
}
