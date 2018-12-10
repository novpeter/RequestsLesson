//
//  UserViewController.swift
//  VKNews
//
//  Created by Петр on 01/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var smallAvatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var newPostTextField: UITextField!
    @IBOutlet weak var publishNewPostButton: UIButton!
    
    var vkManager: VKManager!
    var dataManager: DataManagerProtocol!
    var requestManager: RequestManagerProtocol!
    
    var user: User! {
        didSet {
            configurePage()
            applyStyles()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for view in [nameLabel, aliasLabel, statusLabel, phoneLabel, birthdayLabel, townLabel] {
            view!.backgroundColor = UIColor.clear
            view?.text = ""
        }
        
        vkManager = VKManager.sharedInstance
        dataManager = DataManager.sharedInstance
        requestManager = RequestManager.sharedInstance
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.tabBarController?.navigationItem.title = PageTitles.Loading.rawValue
        
        vkManager.updateUserInfo { [weak self] (response) in
            
            guard let self = self else { return }
            
            switch response {
            case .success(let data):
                
                if let user = data.response.first {
                    
                    let _ = User.init(context: self.dataManager.context, user: user)
                    self.dataManager.saveContext()
                    self.dataManager.asyncGetAll(with: User.self, completionBlock: { (result) in
                        
                        if let currentUser = result?.first {
                            self.user = currentUser
                            
                            self.requestManager.loadImage(with: user.photo) { (response) in
                                
                                switch (response) {
                                case .success(let data):
                                    self.avatarImageView.image = UIImage(data: data)
                                    self.smallAvatarImageView.image = UIImage(data: data)
                                case .failure(let error):
                                    print("Error: \(error.localizedDescription)")
                                }
                                self.tabBarController?.navigationItem.title = PageTitles.User.rawValue
                            }
                        }
                    })
                    
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func publishNewPostTextField(_ sender: Any) {
        
        newPostTextField.isUserInteractionEnabled = false
        
        if let postText = newPostTextField.text, postText.count > 0 {
            
            tabBarController?.navigationItem.title = PageTitles.Publishing.rawValue
            publishNewPostButton.isEnabled = false
            
            vkManager.publishNewPost(with: postText) { [weak self ] (success) in
                
                guard let self = self else { return }
                
                if success {
                    self.newPostTextField.text = ""
                }
                
                self.tabBarController?.navigationItem.title = PageTitles.User.rawValue
                self.publishNewPostButton.isEnabled = true
                self.newPostTextField.isUserInteractionEnabled = true
            }
        }
    }
    
    private func configurePage() {

        nameLabel.text = "\(user.firstName!) \(user.lastName!)"
        
        configureLabel(label: aliasLabel, text: user.screenName!, resultText: "@ \(user.screenName!)")
        configureLabel(label: statusLabel, text: user.status!, resultText: "\"\(user.status!)\"")
        configureLabel(label: phoneLabel, text: user.phone!, resultText: "phone: \(user.phone!)")
        configureLabel(label: birthdayLabel, text: user.birthday!, resultText: "bithday: \(user.birthday!)")
        configureLabel(label: townLabel, text: user.homeTown!, resultText: "town: \(user.homeTown!)")
    }
    
    private func configureLabel(label: UILabel, text: String, resultText: String) {
    
        if text.isEmpty {
            label.isHidden = true
        }
        else {
            label.text = resultText
        }
    }
    
    private func applyStyles() {
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.clipsToBounds = true
        
        smallAvatarImageView.layer.cornerRadius = smallAvatarImageView.frame.width / 2
        smallAvatarImageView.clipsToBounds = true
        
    }

}
