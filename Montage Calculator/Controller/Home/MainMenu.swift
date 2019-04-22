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
import SVProgressHUD

class MainMenu: UIViewController {

    let webView = WKWebView()
    let webViewEstate = WKWebView()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func openWebPageTitle(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Loading...")
//        let url = URL(string: "https://www.yuchakcorp.com/blog")!
//        let request = URLRequest(url: url)
//        webView.load(request)
        webView.reload()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
                do {
                    //print ("innerHTML is : \(innerHTML)")
                    let segueWebScraping = try WebScraping(innerHTML, "information")
                    guard segueWebScraping.contents.count != 0  else {
                        SVProgressHUD.dismiss()
                        self.ShowWebError()
                        return
                    }
                    self.performSegue(withIdentifier: "segue", sender: segueWebScraping.contents)
                    SVProgressHUD.dismiss()
    
                } catch {
                    print (error)
                }
            }
        }

    }
    @IBAction func openHouseInfo(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Loading...")
//        let url = URL(string: "https://www.yuchakcorp.com/canadianestate")!
//        let request = URLRequest(url: url)
//        webView.load(request)
        webViewEstate.reload()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.webViewEstate.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
                do {
                    //print ("innerHTML is : \(innerHTML)")
                    let segueWebScraping = try WebScraping(innerHTML, "estate")
                    guard segueWebScraping.contents.count != 0  else {
                        SVProgressHUD.dismiss()
                        self.ShowWebError()
                        return
                    }
                    self.performSegue(withIdentifier: "segue", sender: segueWebScraping.contents)
                    SVProgressHUD.dismiss()
                    
                } catch {
                    print (error)
                }
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
        print("item 1 loaded")

        let url = URL(string: "https://www.yuchakcorp.com/blog")!
        let request = URLRequest(url: url)
        let eurl = URL(string: "https://www.yuchakcorp.com/canadianestate")!
        let erequest = URLRequest(url: eurl)
        webViewEstate.load(erequest)
        webView.load(request)
        
        
    }
    



}
