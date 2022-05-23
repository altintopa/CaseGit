//
//  MovieModel.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 26/04/2022.
//

import Foundation

struct Movie: Codable {
    let movieImage: String
    let movieTitle: String
    let movieYear: Int
    let movieGenre: String
    let isPopular, isRecommended: Bool
}
