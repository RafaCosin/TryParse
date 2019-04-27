//
//  Modelo.swift
//  TryParse
//
//  Created by kino on 25/04/2019.
//  Copyright © 2019 Rafa Cosin. All rights reserved.
//

import Foundation
struct MovieResults : Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}
struct Movie: Decodable {
    let id: Int
    let posterPath: String
    let backdrop: String
    let title: String
    var releaseDate: String
    let year: String
    var rating: Double
    let overview: String
    
    
    init(id: Int, posterPath: String,  backdrop: String, title: String, releaseDate: String, year: String, rating: Double, overview: String) {
        self.id = id
        self.posterPath = posterPath
        self.backdrop = backdrop
        self.title = title
        self.releaseDate = releaseDate
        self.year = year
        self.rating = rating
        self.overview = overview
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case release = "release_date"
        case rating = "vote_average"
        case overview
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let posterPath: String = try container.decode(String.self, forKey:  .posterPath)
        let backdrop: String = try container.decode(String.self, forKey: .backdrop)
        let title: String = try container.decode(String.self, forKey: .title)
        let releaseDate: String = try container.decode(String.self, forKey: .release)
        let year: String = String(releaseDate.prefix(4))
        let rating: Double = try container.decode(Double.self, forKey: .rating)
        let overview: String = try container.decode(String.self, forKey: .overview)
        
        self.init(id: id, posterPath: posterPath, backdrop: backdrop, title: title, releaseDate: releaseDate, year: year, rating: rating, overview: overview)
    }
}
