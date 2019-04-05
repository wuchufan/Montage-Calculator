//
//  MainMenu.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-03-25.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit
import WebKit
import MessageUI

class MainMenu: UIViewController {

    let webView = WKWebView()
    @IBAction func openWebPageTitle(_ sender: Any) {
        webView.reload()
        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
            do {
                print ("innerHTML is : \(innerHTML)")
                let segueWebScraping = try WebScraping(innerHTML)
                guard segueWebScraping.contents.count != 0  else {
                    self.ShowWebError()
                    return
                }
                self.performSegue(withIdentifier: "segue", sender: segueWebScraping.contents)
            } catch {
                print (error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let contents = sender as AnyObject as? [WebContent], let destination = segue.destination as? Website else {
            return
        }
        destination.receivedWebContent = contents
    }
    
    func ShowWebError(){
        let sendWebErrorAlert = UIAlertController(title: "Could not load website", message: "Could not load website, try again later", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Fine", style: .default, handler: nil)
        sendWebErrorAlert.addAction(dismiss)
        self.present(sendWebErrorAlert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.yuchakcorp.com/blog")!
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    



}
