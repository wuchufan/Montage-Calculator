//
//  UIdesign.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-04-23.
//  Copyright © 2019 TIEC. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func buttonDesign(){
        self.layer.cornerRadius = 0.05 * self.bounds.size.width
        self.layer.shadowOffset = CGSize(width: 0, height: 0)

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.8

    }

}

extension UIButton {
    func trueButtonDesign(){

        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        //        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.8
        //        self.layer.shouldRasterize = true
        //        self.layer.masksToBounds = false
        
    }
}
