//
//  TableCell.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 28/04/2022.
//

import UIKit

class TableCell: UITableViewCell {
    

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblCreatedDate: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(data: Users){
        
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        
        lblComment.text = data.postMessage
        lblUserName.text = data.userFullName
        lblCreatedDate.text = data.createdAt
        lblLikeCount.text = "\(data.likeCount)"
        lblCommentCount.text = "\(data.commentCount)"
        userImage.load(url: URL(string: "\(data.userImageURL)")!)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
