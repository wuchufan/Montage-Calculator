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
    var labelHeight = [CGFloat]()
    var imagesParameters = [ImageParameter]()
    var images = [UIImageView]()
    var titles = [String]()

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedWebContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("IOWEJQOIWJE")
        let cell = titleContainer.dequeueReusableCell(withIdentifier: "webTitleCell", for: indexPath) as! webTitleCell

        cell.webArticleTitle.text! = titles[indexPath.row] 
        labelHeight.append(cell.webArticleTitle.frame.height)
//        print(labelHeight)
//        print("height of label is0 :\(cell.webArticleTitle.frame.height)")
        let image = receivedWebContent[indexPath.row].imageLink
        let imageURL = URL(string: "\(image)")
 
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.webArticleImage.image = UIImage(data: data!)
                
                print("height of label is :\(cell.webArticleTitle.frame.height)")
                print("height of the image is :\(cell.webArticleImage.image?.size.height)")
                print("width of the image is :\(cell.webArticleImage.image?.size.width)")
                print("height of the imageView is :\(cell.webArticleImage.frame.height)")
                print("width of the imageView is : \(cell.webArticleImage.frame.width)")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ratio = getImageWidthHeightRatio(indexPath: indexPath)
        let text = titles[indexPath.row]
        let estimatedheight = calculateEstimatedHeight(text: text)
//        print("qweqweqwe")
        print ("estimated height of image : \(view.frame.width/ratio)")
        print("estimated height of label :\(estimatedheight.height)")
        return CGFloat(view.frame.width/ratio + estimatedheight.height)
    }
    
    func configureTitle(){
//        let cell = webTitleCell()
        for i in 0..<receivedWebContent.count {
            titles.append(receivedWebContent[i].title)
//            cell.webArticleTitle.text! = titles[i]
//            print(cell.webArticleTitle.frame.height)
        }
    }
    func configureImage(){
        for i in 0..<receivedWebContent.count{
            let image = receivedWebContent[i].imageLink
            let imageURL = URL(string: "\(image)")
            let data = try? Data(contentsOf: imageURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let cgh = UIImage(data: data!)!.size.height
            let cgw = UIImage(data: data!)!.size.width
            let parameter = ImageParameter(width: cgw, height: cgh)
            imagesParameters.append(parameter)
        }

    }
    func getImageWidthHeightRatio(indexPath: IndexPath) -> CGFloat{
        let ratio = CGFloat(imagesParameters[indexPath.row].width / imagesParameters[indexPath.row].height)
        return ratio
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DisplayWebPage
        destination.displayWebLink = sender as? String
    }
    
//    func configureTableView(){
//        titleContainer.rowHeight = UITableView.automaticDimension
//        titleContainer.estimatedRowHeight = 25
//    }
    func calculateEstimatedHeight(text:String) -> CGRect{
        let size = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attribute = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 21)]
//        let attribute = [NSAttributedString.Key.font:
        let estimatedHeight = NSString(string: text).boundingRect(with: size, options: options, attributes: attribute, context: nil)

        return estimatedHeight
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleContainer.delegate = self
        titleContainer.dataSource = self
        titleContainer.register(UINib(nibName: "webTitleCell", bundle: nil), forCellReuseIdentifier: "webTitleCell")
        configureTitle()
        configureImage()
//                titleContainer.rowHeight = UITableView.automaticDimension
//                titleContainer.estimatedRowHeight = 120
//        configureTableView()

        
        

        
    }
    


}
