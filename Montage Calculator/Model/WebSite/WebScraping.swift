//
//  WebScraping.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-04-04.
//  Copyright © 2019 TIEC. All rights reserved.
//

import Foundation
import SwiftSoup

enum HTMLError: Error {
    case badInnerHTML
}

class WebScraping {
    
    let contents : [WebContent]
    
    init (_ html: Any?) throws {
        
        
        guard let htmlString = html as? String else { throw HTMLError.badInnerHTML}
        
        let linkSorting = LinkSorting()
        let doc = try SwiftSoup.parse(htmlString)

        let webTitles = try doc.getElementsByClass("font_5").array()
        let link = try doc.getElementsByAttributeValueContaining("href", "https://www.yuchakcorp.com/single-post").array()
        let webLinks = linkSorting.checkHerf(htmlArray: link)
        
//
//        print("------------------------------------------ Doc Begins -------------------------------------------")
//        print(doc)
//        print("------------------------------------------ Doc Ends -------------------------------------------")
//        print(link)
//        print("------------------------------------------ Link Ends -------------------------------------------")
//        print(webTitles)
//        print("------------------------------------------ WebTitles Ends -------------------------------------------")
//        print(webLinks)
//        print("------------------------------------------ WebLinks Ends -------------------------------------------")
//
//
        var contents = [WebContent]()
        for i in 0..<webTitles.count{
            let titles = try webTitles[i].text()
            let links = webLinks[i]
            let content = WebContent(title: titles, link: links)
            contents.append(content)
            
        }
        
        self.contents = contents
        print("self.contents is : \(self.contents)")
        print("------------------------------------------ Iteration Ends -------------------------------------------")
        
        
        
    }
    
    
}


