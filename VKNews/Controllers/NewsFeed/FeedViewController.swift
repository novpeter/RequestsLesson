//
//  FeedViewController.swift
//  VKNews
//
//  Created by Петр on 01/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataManager: DataManagerProtocol!
    var vkManager: VKManager!
    var requestManager: RequestManagerProtocol!
    
    var currentPosts: [Post]!
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataManager = DataManager.sharedInstance
        vkManager = VKManager.sharedInstance
        requestManager = RequestManager.sharedInstance
        
        tableView.addSubview(self.refreshControl)
        tableView.estimatedRowHeight = CGFloat(estimatedRowHeight)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.tabBarController?.navigationItem.title = PageTitles.Feed.rawValue
        
        vkManager.updatePosts { [weak self] (posts) in
            
            guard let self = self else { return }
            
            self.currentPosts = posts.sorted(by: {$0.date > $1.date})
            
            self.tableView.reloadData()
        }
  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currentPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: postIdentifier) as! PostTableViewCell
        
        cell.congigureCell(with: currentPosts[indexPath.section])
        
        return cell
    }
    
    /// Reload table data
    ///
    /// - Parameter refreshControl
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        vkManager.updatePosts { [weak self] (posts) in
            
            guard let self = self else { return }
            
            self.currentPosts = posts
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
}
