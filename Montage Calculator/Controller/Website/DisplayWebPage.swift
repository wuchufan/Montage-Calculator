//
//  DisplayWebPage.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-04-04.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit
import WebKit
class DisplayWebPage: UIViewController {
    
    var displayWebLink : String!
    @IBOutlet weak var web: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "\(displayWebLink!)")
        let request = URLRequest(url: url!)
        web.load(request)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
