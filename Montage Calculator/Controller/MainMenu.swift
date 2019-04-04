//
//  MainMenu.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-03-25.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit
import WebKit

class MainMenu: UIViewController {

    let webView = WKWebView()
    @IBAction func openWebPageTitle(_ sender: Any) {
        webView.reload()
        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
            do {
                let segueWebScraping = try WebScraping(innerHTML)
                self.performSegue(withIdentifier: "segue", sender: segueWebScraping.contents)
            } catch {
                print (error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let contents = try sender as AnyObject as? [WebContent], let destination = try segue.destination as? Website else {
            return
        }
        destination.receivedWebContent = contents
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.yuchakcorp.com/blog")!
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    



}
