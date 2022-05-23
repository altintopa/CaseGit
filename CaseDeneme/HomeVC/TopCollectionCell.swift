//
//  CollectionCell.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 23/04/2022.
//

import UIKit

class TopCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieType: UILabel!
    
    func configureCell(data : Movie){
    
        movieImage.layer.cornerRadius = 8
        lblMovieType.layer.masksToBounds = true
        lblMovieType.layer.cornerRadius = 2
        
        lblMovieName.text = data.movieTitle
        lblMovieDuration.text = "\(data.movieYear)"
        lblMovieType.text = " \(data.movieGenre.replacingOccurrences(of: "|", with: " , ")) "
       
         
        movieImage.load(url: URL(string: "\(data.movieImage)")!)
        if movieImage.image == nil {
            print(data.movieImage)
            movieImage.load(url: URL(string: "https://i.pinimg.com/originals/10/0c/9c/100c9cbc784b0c0f7cd3cac70a206f62.jpg")!)
        }
        
    }
    
}


