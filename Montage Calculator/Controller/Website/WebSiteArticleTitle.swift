//
//  Website.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-03-26.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit
import WebKit

class Website: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleContainer: UITableView!
    var receivedWebContent : [WebContent]!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedWebContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = receivedWebContent[indexPath.row].title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSentToWebPage = receivedWebContent[indexPath.row].link
        performSegue(withIdentifier: "segueToWebPage", sender: dataSentToWebPage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DisplayWebPage
        destination.displayWebLink = sender as? String
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleContainer.delegate = self
        titleContainer.dataSource = self
        

        
    }
    


}
