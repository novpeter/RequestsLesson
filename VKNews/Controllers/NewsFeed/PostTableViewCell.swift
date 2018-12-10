//
//  PostTableViewCell.swift
//  VKNews
//
//  Created by Петр on 01/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var attachedImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    
    var requestManager: RequestManagerProtocol!
    var vkManager: VKManager!
    var dataManager: DataManagerProtocol!
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sourceNameLabel.text = nil
        avatarImageView.image = nil
        likeButton.setImage(UIImage(named: "like_icon"), for: .normal)
        likeButton.setTitle(nil, for: .normal)
        commentButton.setTitle(nil, for: .normal)
        repostButton.setTitle(nil, for: .normal)
        mainTextLabel.text = nil
        dateLabel.text = nil
        attachedImage.image = nil
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
                
        if post.userLikes == 1 {
            post.likesCount = post.likesCount - 1
            post.userLikes = 0
            likeButton.setImage(UIImage(named: "like_icon"), for: .normal)
            configureButton(button: likeButton, title: String(describing: post!.likesCount))
            
        }
        else {
            post.likesCount = post.likesCount + 1
            post.userLikes = 1
            likeButton.setImage(UIImage(named: "user_likes_icon"), for: .normal)
            configureButton(button: likeButton, title: String(describing: post!.likesCount))
            
            vkManager.likePost(with: post) { [weak self] (likesCount) in
                
                guard let self = self else { return }
                
                if let likesCount = likesCount {
                    self.post.likesCount = Int64(likesCount)
                    self.configureButton(button: self.likeButton, title: String(describing: self.post!.likesCount))
                }
                else {
                    self.post.likesCount = self.post.likesCount - 1
                    self.post.userLikes = 0
                    self.likeButton.setImage(UIImage(named: "like_icon"), for: .normal)
                    self.configureButton(button: self.likeButton, title: String(describing: self.post!.likesCount))
                }
                self.dataManager.saveContext()
            }
        }

        dataManager.saveContext()
 
    }
    
    func congigureCell(with post: Post) {
        
        self.post = post
        
        dataManager = DataManager.sharedInstance
        requestManager = RequestManager.sharedInstance
        vkManager = VKManager.sharedInstance
            
        sourceNameLabel.text = post.sourceName
        
        dateLabel.text = format(duration: TimeInterval(post.date))
        mainTextLabel.text = post.text
        
        configureButton(button: self.likeButton, title: String(describing: post.likesCount))
        configureButton(button: self.repostButton, title: String(describing: post.repostsCount))
        configureButton(button: self.commentButton, title: String(describing: post.commentsCount))
        
        if post.userLikes == 1 {
            
            likeButton.setImage(UIImage(named: "user_likes_icon"), for: .normal)
        }
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }

            if let avatarImage = post.sourceAvatar {

                self.requestManager.loadImage(with: avatarImage) { (response) in
                    
                    switch (response) {
                    case .success(let data):
                        self.avatarImageView.image = UIImage(data: data)
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }

            if let attachedImage = post.attachedImage {

                self.requestManager.loadImage(with: attachedImage) { (response) in

                    switch (response) {
                    case .success(let data):
                        self.attachedImage.image = UIImage(data: data)
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
        
        applyStyles()
    }

    private func configureButton(button: UIButton, title: String?) {
        button.setTitle(" \(title ?? "0")", for: .normal)
    }
    
    
    private func applyStyles() {
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.clipsToBounds = true
    }
}
