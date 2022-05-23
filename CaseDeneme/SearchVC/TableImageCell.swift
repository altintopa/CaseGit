//
//  TableImageCell.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 28/04/2022.
//

import UIKit

class TableImageCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblCreatedDate: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(data: Users , indexpath:Int){
        
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        
        lblComment.text = data.postMessage
        lblUserName.text = data.userFullName
        lblCreatedDate.text = data.createdAt
        lblLikeCount.text = "\(data.likeCount)"
        lblCommentCount.text = "\(data.commentCount)"
        
        userImage.load(url: URL(string: "\(data.userImageURL)")!)
        movieImage.load(url: URL(string: "\(data.postImage)")!)
        
        if movieImage.image == nil {
            /// buraya API'den data gelmediği için ve tek bir image değilde  farklı image'lar teşhir edilsin diye bu şekilde yazdım.
            let images = ["MarriageStory","NickCage","Thor","OldGuard","TheAdamProject","TurningRed","MarriageStory","OldGuard","MarriageStory","TheAdamProject", "MarriageStory", "6undeground"]
            movieImage.image = UIImage(named: images[.random(in: 0..<images.count)])
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
