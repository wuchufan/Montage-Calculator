//
//  LinkSorting.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-04-04.
//  Copyright © 2019 TIEC. All rights reserved.
//

import Foundation
import SwiftSoup
class LinkSorting {
    
    var linkHrefArray = [String]()
    var imageLinkArray = [String]()
    
    func checkHerf (htmlArray : Array<Element>) -> [String] {
        for hrefElement in htmlArray {
            do {
                let linkHref = try hrefElement.attr("href")
                linkHrefArray.append(linkHref)
            } catch Exception.Error(let type, let message) {
                print (message)
            } catch {
                print (error)
            }
        }
        let noDuplicateHrefArray = Array(NSOrderedSet(array: linkHrefArray)) as! [String]
        return noDuplicateHrefArray
    }
    
    func checkImageLink (imageArray : Array<Element>) ->[String] {
        for element in imageArray {
            do {
                let es = try element.attr("src")
                imageLinkArray.append(es)
            } catch Exception.Error(let type, let message) {
                print (message)
            } catch {
                print (error)
            }
        }
        return imageLinkArray

    }
}
