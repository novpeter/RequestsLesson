//
//  SplashViewController.swift
//  VKNews
//
//  Created by Петр on 30/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var dataManager: DataManagerProtocol!
    var vkManager: VKManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataManager = DataManager.sharedInstance
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(splashScreenDelay)) { [weak self] in
            
            guard let self = self else { return }
                
            if let _ = self.dataManager.getClient(with: VKClient.self) {
                self.performSegue(withIdentifier: Seques.NewsFeed.rawValue, sender: self)
            }
            else {
                self.performSegue(withIdentifier: Seques.LoginSegue.rawValue, sender: self)
            }
        }
    }

}
