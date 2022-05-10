//
//  BottomCollectionCell.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 26/04/2022.
//

import UIKit

class BottomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    
    func configureCell( data: Movie){
        
        movieImage.layer.cornerRadius = 8
        
        lblMovieName.text = data.movieTitle
        lblMovieDuration.text = "\(data.movieYear)"
        
        movieImage.load(url: URL(string: "\(data.movieImage)")!)
        if movieImage.image == nil {
            movieImage.load(url: URL(string: "https://i.pinimg.com/originals/05/5e/b5/055eb5581ce9fcb262b767365d673aef.jpg")!)
        }
    }
}
