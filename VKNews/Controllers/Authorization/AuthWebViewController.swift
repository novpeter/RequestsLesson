//
//  AuthWebViewController.swift
//  VKNews
//
//  Created by Петр on 03/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit
import WebKit

class AuthWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var vkManager: VKManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        vkManager = VKManager.sharedInstance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let request = URLRequest(url: URL(string: VKLinks.token.rawValue)!)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        if let currentUrl = webView.url, currentUrl.absoluteString.contains(accessTokenParameter) {
                        
            let url = currentUrl.absoluteString.replacingOccurrences(of: "blank.html#", with: "?")
            
            var credentials = [String:String]()

            if let queryItems = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: false)!.queryItems {
                for item in queryItems {
                    credentials[item.name] = item.value!
                }
            }
            
            vkManager.createAndSaveClient(credentials: credentials)
        
            performSegue(withIdentifier: Seques.AuthSuccess.rawValue, sender: self)
        }
        
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
