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

        let cell = titleContainer.dequeueReusableCell(withIdentifier: "webTitleCell", for: indexPath) as! webTitleCell
        cell.webArticleTitle.text! = receivedWebContent[indexPath.row].title 
        let image = receivedWebContent[indexPath.row].imageLink
        let imageURL = URL(string: "\(image)")
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.webArticleImage.image = UIImage(data: data!)
            }
        }

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSentToWebPage = receivedWebContent[indexPath.row].link
        performSegue(withIdentifier: "segueToWebPage", sender: dataSentToWebPage)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = titleContainer.dequeueReusableCell(withIdentifier: "webTitleCell", for: indexPath) as! webTitleCell
//        cell.webArticleTitle
//        return CGFloat(
//    }
//
//    func getImageView (
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DisplayWebPage
        destination.displayWebLink = sender as? String
    }
    
//    func configureTableView(){
//        titleContainer.rowHeight = UITableView.automaticDimension
//        titleContainer.estimatedRowHeight = 120.0
//    }
//
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleContainer.delegate = self
        titleContainer.dataSource = self
        titleContainer.register(UINib(nibName: "webTitleCell", bundle: nil), forCellReuseIdentifier: "webTitleCell")
//        configureTableView()
        
        

        
    }
    


}
