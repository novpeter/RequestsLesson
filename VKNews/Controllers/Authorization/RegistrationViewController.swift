//
//  RegistrationViewController.swift
//  VKNews
//
//  Created by Петр on 30/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.alpha = 0
        loginButton.alpha = 0
        loginButton.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) {
            
            self.welcomeLabel.alpha = 1
            self.loginButton.alpha = 1
        }
    }

}
