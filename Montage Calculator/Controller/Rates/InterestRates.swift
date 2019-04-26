//
//  InterestRates.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-04-11.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit

class InterestRates: UIViewController {

    @IBOutlet weak var TDTag: UIView!
    @IBOutlet weak var Scotiabank: UIView!
    @IBOutlet weak var RBC: UIView!
    @IBOutlet weak var BOM: UIView!
    @IBOutlet weak var CIBC: UIView!
    @IBOutlet weak var NBOC: UIView!
    
    @IBOutlet weak var buttonTD: UIButton!
    @IBOutlet weak var buttonScotiaBank: UIButton!
    @IBOutlet weak var buttonRBC: UIButton!
    @IBOutlet weak var buttonBOM: UIButton!
    @IBOutlet weak var buttonNBOC: UIButton!
    @IBOutlet weak var buttonCIBC: UIButton!
    
    @IBAction func toCalculator(_ sender: Any) {
        print("it works")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TDTag.buttonDesign()
        Scotiabank.buttonDesign()
        RBC.buttonDesign()
        BOM.buttonDesign()
        CIBC.buttonDesign()
        NBOC.buttonDesign()
        buttonTD.trueButtonDesign()
        buttonScotiaBank.trueButtonDesign()
        buttonRBC.trueButtonDesign()
        buttonBOM.trueButtonDesign()
        buttonCIBC.trueButtonDesign()
        buttonNBOC.trueButtonDesign()
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
