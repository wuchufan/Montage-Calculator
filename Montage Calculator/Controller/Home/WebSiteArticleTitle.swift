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
    var imagesHeight = [CGFloat]()
    var images = [UIImageView]()
    var titles = [String]()
//    var labelHeight : CGFloat!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedWebContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = titleContainer.dequeueReusableCell(withIdentifier: "webTitleCell", for: indexPath) as! webTitleCell
//        cell.webArticleTitle.text! = receivedWebContent[indexPath.row].title
        cell.webArticleTitle.text! = titles[indexPath.row]
        let image = receivedWebContent[indexPath.row].imageLink
        let imageURL = URL(string: "\(image)")

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.webArticleImage.image = UIImage(data: data!)
            }
        }

        print("height of label is :\(cell.webArticleTitle.frame.height)")
        print("height of the image is :\(cell.webArticleImage.image?.size.height)")
        print("width of the image is :\(cell.webArticleImage.image?.size.width)")
        print("height of the imageView is :\(cell.webArticleImage.frame.height)")
        print("width of the imageView is : \(cell.webArticleImage.frame.width)")
//        labelHeight = cell.webArticleTitle.frame.height
//        print("in cell at row: \(labelHeight)")
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
////        guard labelHeight != nil else {return CGFloat}
////        print("qwdqdwqwdwq\(labelHeight)")
//
//        return CGFloat(imagesHeight[indexPath.row]+25.5)
//    }
    
    func configureTitle(){
        for i in 0..<receivedWebContent.count {
            titles.append(receivedWebContent[i].title)
        }
    }
//    func configureImage(){
//        var cg = CGFloat()
//        for i in 0..<receivedWebContent.count{
//
//            let image = receivedWebContent[i].imageLink
//            let imageURL = URL(string: "\(image)")
//
//            let data = try? Data(contentsOf: imageURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//
//            cg = UIImage(data: data!)!.size.height
//            self.imagesHeight.append(cg)
////            print("inclosure: \(self.imagesHeight)")
//        }
//
////        print("out of closure: \(imagesHeight)")
//    }

    
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
        configureTitle()
//        configureImage()
//        configureTableView()
        
        

        
    }
    


}
