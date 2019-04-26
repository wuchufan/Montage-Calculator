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
    var buttonIdentifier : Int = 0

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var estateView: UIView!
    @IBAction func openWebPageTitle(_ sender: UIButton) {
        buttonIdentifier = sender.tag
        SVProgressHUD.show(withStatus: "Loading...")
        webView.reload()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
                do {
                    //print ("innerHTML is : \(innerHTML)")
                    let segueWebScraping = try WebScraping(innerHTML)
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
    @IBAction func openHouseInfo(_ sender: UIButton) {
        buttonIdentifier = sender.tag
        SVProgressHUD.show(withStatus: "Loading...")
        webViewEstate.reload()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.webViewEstate.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
                do {
                    //print ("innerHTML is : \(innerHTML)")
                    let segueWebScraping = try EstateWebScraping(innerHTML)
                    guard segueWebScraping.estateContents.count != 0  else {
                        SVProgressHUD.dismiss()
                        self.ShowWebError()
                        return
                    }
                    self.performSegue(withIdentifier: "segueToEstate", sender: segueWebScraping.estateContents)
                    SVProgressHUD.dismiss()
                    
                } catch {
                    print (error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if buttonIdentifier == 0 {
            let contents = sender as AnyObject as? [WebContent]
            let destination = segue.destination as? Website
            if let contents = contents, let destination = destination {destination.receivedWebContent = contents} else {print ("it is nil")}
        } else if buttonIdentifier == 1 {
            let contents = sender as AnyObject as? [EstateWebContent]
            let destination = segue.destination as? Estate
            if let contents = contents, let destination = destination {destination.estateReceivedContent = contents} else {print ("it is nil")}
        }
        

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
        infoView.buttonDesign()
        estateView.buttonDesign()
        webViewEstate.load(erequest)
        webView.load(request)
        
        
    }
    



}
