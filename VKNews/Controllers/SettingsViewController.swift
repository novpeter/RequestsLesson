//
//  SettingsViewController.swift
//  VKNews
//
//  Created by Петр on 01/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var dataManager: DataManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager = DataManager.sharedInstance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.tabBarController?.navigationItem.title =  PageTitles.Settings.rawValue
    }
    
}
