//
//  DetailViewController.swift
//  TryParse
//
//  Created by kino on 28/04/2019.
//  Copyright © 2019 Rafa Cosin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var movie : Movie!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dataReleaseLabel: UILabel!
    @IBOutlet weak var textview: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie.title
        dataReleaseLabel.text = "Data release : " +  movie.releaseDate
        textview.text = movie.overview
        textview.isUserInteractionEnabled = true
        
        let completa = ensambleURL(size: "w500", posterPath: movie.posterPath)
        
        imageFromURL(url: completa, imgcompletionHandler: {(image,error) in
            if let imagen = image {
                
                DispatchQueue.main.async {
                    self.posterImage.image = imagen
                }
            }
        })
    }
    


}
