//
//  StoriesCell.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 28/04/2022.
//

import UIKit

class StoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    func configureCell(data: Users){
        
        userImage.clipsToBounds = true
        userImage.layer.borderColor = UIColor.blue.cgColor
        userImage.layer.borderWidth = 1
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        
        lblUserName.text = data.userFullName
        userImage.load(url: URL(string: "\(data.userImageURL)")!)
        
        /// en son kontrollerde resim yükleniyordu.  Ancak şuanda gelen url'den 500 internal server Hatası geliyor. .
        if userImage.image == nil {
            print(data.userImageURL)
            let images = ["MarriageStory","NickCage","Thor","OldGuard","TheAdamProject","TurningRed","MarriageStory","OldGuard","MarriageStory","TheAdamProject", "MarriageStory", "6undeground"]

            userImage.image = UIImage(named: "Thor")
            userImage.image = UIImage(named: <#T##String#>)
        }
        
    }
    
    func configureDefaultCell(){
        lblUserName?.text = "You"
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        userImage.image = UIImage(named: "group2")
    }
}
