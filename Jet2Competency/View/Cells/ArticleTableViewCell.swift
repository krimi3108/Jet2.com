//
//  ScheduleListTableViewCell.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import UIKit


class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var labelCreatedAt: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserDesignation: UILabel!
    @IBOutlet weak var labelArticleImage: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelUrl: UILabel!
    @IBOutlet weak var labelLikes: UILabel!
    @IBOutlet weak var labelComments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        imageUser.layer.cornerRadius = imageUser.frame.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var listData: Article? {
        didSet {
            guard let article = listData else { return }
            
            labelCreatedAt.text = Date.getTimeDiffernce(from: article.user?.createdAt ?? "")
            
            imageUser.downloadImage(from: article.user?.avatar ?? "", placeHolderImage: UIImage(systemName: "person.circle.fill")!)
            labelUserName.text = "\(article.user?.name ?? "") \(article.user?.lastname ?? "")"
            labelUserDesignation.text = article.user?.designation
            
            labelArticleImage.downloadImage(from: article.media?.image ?? "", placeHolderImage: UIImage(systemName: "doc.text.fill")!)

            labelDescription.text = article.content
            labelTitle.text = article.media?.title
            labelUrl.text = article.media?.url
            
            labelLikes.text = "\(article.likes/1000)K Likes"
            labelComments.text = "\(article.comments/1000)K Comments"
        }
    }
}
