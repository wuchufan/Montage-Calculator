//
//  ViewController.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-03-06.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit

extension UITextField{

    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    

    
    @IBOutlet weak var calculationDataTableView: UITableView!
    
    
    let firstSectionCell = TableViewCell()
    let mortageCalculator = MortageCalculator()
    var textFieldDataContainer = [Double]()
    var textFieldReloader = "0"
    var cellRowAndTextFieldTag : Int!
    let cellLabelArray=[["Home Price","Down Payment", "Down Payment Rate","Interest Rate","Amortization"],["Loan","Monthly","Bi-weekly","Weekly"]]
    var cellHeightsDictionary: [IndexPath: CGFloat] = [:]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting tableview delegate
        calculationDataTableView.delegate = self
        calculationDataTableView.dataSource = self

        
        //registering Xib files
        calculationDataTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        calculationDataTableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "resultTableViewCell")
        
        //Initializing CellLabelArray
        OutletTextInitializer(rows: cellLabelArray[0].count)
//
//        calculationDataTableView.rowHeight = UITableView.automaticDimension
//        calculationDataTableView.estimatedRowHeight = 300

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    

    //MARK: TableView stuff
    override func viewWillAppear(_ animated: Bool) {

        print("the height of TableView is: \(self.view.frame.height)")
        print("the height of navigation bar is :\( self.navigationController!.navigationBar.frame.size.height)")
        print("the height of sectoinFooterHeight is :\(self.calculationDataTableView.sectionFooterHeight)")
        calculationDataTableView.rowHeight = ((self.view.frame.height  - self.navigationController!.navigationBar.frame.size.height) / 9)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { //these block and the block below prevents program from jumpping when deselect tableviewcell
        // print("Cell height: \(cell.frame.size.height)")
        self.cellHeightsDictionary[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat { // Look above
        if let height =  self.cellHeightsDictionary[indexPath] {
            return height
        }
        return UITableView.automaticDimension
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 { // If it is the first section, give me 4 rows, otherwise give me 3 rows
            return 5
        } else {
            return 4
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        //MARK:Setting up TableView, linking CustomCells to this tableView
        print("does it start from here?")
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        let resultCell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell", for: indexPath) as! ResultTableViewCell
        
        //MARK:Setting up the TextField delegate
        cell.cellLabelNumber.delegate = self
        

        //MARK:Setting up textField text! value, customizing keyboard, customizing clears on eiditing textfield, setting up placeholder properties etc
        cell.cellLabelNumber.text! = textFieldReloader
        cell.cellLabelNumber.keyboardType = .decimalPad
        cell.cellLabelNumber.clearsOnBeginEditing = true
        if indexPath.row == 2 || indexPath.row == 3 {      // this if loop is to set up different units
            
            cell.cellLabelNumber.placeholder = String(textFieldDataContainer[indexPath.row]) + "%"
            
        } else if indexPath.row == 4{
            
            cell.cellLabelNumber.placeholder = String(textFieldDataContainer[indexPath.row]) + " Years"
            
        }
        
        else {
            cell.cellLabelNumber.placeholder = "$" + String(textFieldDataContainer[indexPath.row])
        }

        cell.cellLabelNumber.tag = indexPath.row
        cell.cellLabelNumber.addDoneButtonToKeyboard(myAction: #selector (cell.cellLabelNumber.resignFirstResponder))
        
        //MARK:Programing what should slider do
        
        
        //MARK:Considering different display conditions
        
//        print("textfield before entering the section is: \(cell.cellLabelNumber.text!)")


        if indexPath.section == 0{
            print("it is in section == 0 block after reload, reloading : \(indexPath)")
            print("textfield in this section 0 block being recognized as: \(cell.cellLabelNumber.text!)")
            cell.cellLabel.text = cellLabelArray[indexPath.section][indexPath.row]

            if Double(cell.cellLabelNumber.text!) != nil {  // if you write stuff in the textfield

                textFieldDataContainer[indexPath.row] = Double(cell.cellLabelNumber.text!)!
                
                if indexPath.row == 2 || indexPath.row == 3 {                   //this if loop is for different units just like above, returning the same value but with units added
                    
                    cell.cellLabelNumber.text! = String(textFieldDataContainer[indexPath.row]) + "%"
                    cell.cellLabelNumber.placeholder = String(textFieldDataContainer[indexPath.row]) + "%"
                } else if indexPath.row == 4 {
                    
                    cell.cellLabelNumber.text! = String(textFieldDataContainer[indexPath.row]) + " Years"
                    cell.cellLabelNumber.placeholder = String(textFieldDataContainer[indexPath.row]) + " Years"
                }
                
                else {
                    print("i'had been here")
                    cell.cellLabelNumber.text! = "$" + cell.cellLabelNumber.text!
                    cell.cellLabelNumber.placeholder = "$" + String(textFieldDataContainer[indexPath.row])
                }

            } else {
                print ("the textfield is nil")
                cell.cellLabelNumber.text = cell.cellLabelNumber.placeholder
            }



            print (textFieldDataContainer)


            return cell


            
        } else {
            
//            print("it is in section 2")
            switch indexPath.row{
                
            case 0:

                resultCell.typeOfResult.text = cellLabelArray[indexPath.section][indexPath.row]

                resultCell.result.text! = "$" + String(mortageCalculator.ChangeNumberToTwoDigits(Number: textFieldDataContainer[0] - textFieldDataContainer[1]))
                
            case 1:

                resultCell.typeOfResult.text = cellLabelArray[indexPath.section][indexPath.row]
                resultCell.result.text = mortageCalculator.MonthlyCalculator(textFieldDataContainer[1], textFieldDataContainer[2], textFieldDataContainer[0], textFieldDataContainer[3] / 100.0, textFieldDataContainer[4], "monthly")
                
            case 2:
                resultCell.typeOfResult.text = cellLabelArray[indexPath.section][indexPath.row]
                resultCell.result.text = mortageCalculator.MonthlyCalculator(textFieldDataContainer[1], textFieldDataContainer[2], textFieldDataContainer[0], textFieldDataContainer[3] / 100.0, textFieldDataContainer[4], "bi-weekly")
                
            case 3:
                resultCell.typeOfResult.text = cellLabelArray[indexPath.section][indexPath.row]
                resultCell.result.text = mortageCalculator.MonthlyCalculator(textFieldDataContainer[1], textFieldDataContainer[2], textFieldDataContainer[0], textFieldDataContainer[3] / 100.0, textFieldDataContainer[4], "weekly")
                
            default:
                
                print ("result section default case")
                
                
            }
            

            return resultCell
            
        }


    }
    
    
    
    //this function specifies the number of times it calls to create sections
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        calculationDataTableView.endEditing(true)           //resigning keyboard when clicking on the tableView row
        cellRowAndTextFieldTag = indexPath.row
//        sliderValue.maximumValue = Float(textFieldDataContainer[indexPath.row]*2)
        
    }
    

    //MARK: TextField stuff

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>I Selected TextField: \(textField.tag)<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
        cellRowAndTextFieldTag = textField.tag
        
//        UITableView.animate(withDuration: 0.5, animations:{
//            self.heightConstraint.constant = 308
//            self.view.layoutIfNeeded()})
//
        

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("--------------------in EndEditing--------------------------")
        let reloadIndexPath : IndexPath = [0,textField.tag]
        let reloadDPRateCell : IndexPath = [0,2]
        let reloadDPCell: IndexPath = [0,1]
        let sectionToReload =  1
        let indexSet: IndexSet = [sectionToReload]
        

//        print("reloadIndexPath : \(reloadIndexPath)")
//        calculationDataTableView.beginUpdates()
//        calculationDataTableView.endUpdates()
        
        print ("textfield before reload: \(textField.text!)")
        
        
        //Making DP rate and DP related
        //TODO: Fix the textfield not responding bug when you have the solution. It is due to the refresh of the cell
        
        if textField.tag == 0 {
            
            print ("*********************************** I'm in tag 0 *************************************")
            textFieldReloader = textField.text!
            calculationDataTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
            
//            textFieldReloader = mortageCalculator.DownPaymentAndDownPaymentRateCalculator(homePrice: textFieldDataContainer[0], downPayment: nil, downPaymentRate: textFieldDataContainer[2])
//            
//            print ("TAG IS \(textField.tag)")
//            calculationDataTableView.reloadRows(at: [reloadDPCell], with: .automatic)
            
            
            textFieldReloader = mortageCalculator.DownPaymentAndDownPaymentRateCalculator(homePrice: textFieldDataContainer[0], downPayment: textFieldDataContainer[1], downPaymentRate: nil)
            calculationDataTableView.reloadRows(at: [reloadDPRateCell], with: .automatic)
            

        } else if textField.tag == 1{
            
            print ("*********************************** I'm in tag 1 ***************************************")
            textFieldReloader = textField.text!
            calculationDataTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
            
            textFieldReloader = mortageCalculator.DownPaymentAndDownPaymentRateCalculator(homePrice: textFieldDataContainer[0], downPayment: textFieldDataContainer[1], downPaymentRate: nil)
             print("\(textFieldReloader)")
            calculationDataTableView.reloadRows(at: [reloadDPRateCell], with: .automatic)
            
        } else if textField.tag == 2{
            print ("*********************************** I'm in tag 2 ***************************************")
            textFieldReloader = textField.text!
            calculationDataTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
            
            textFieldReloader = mortageCalculator.DownPaymentAndDownPaymentRateCalculator(homePrice: textFieldDataContainer[0], downPayment: nil, downPaymentRate: textFieldDataContainer[2])
            calculationDataTableView.reloadRows(at: [reloadDPCell], with: .automatic)
            
        } else {
            
            print ("************************************* I'm in tag ELSE *******************************")
            textFieldReloader = textField.text!
            calculationDataTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
        }




        print("textfield after reload: \(textField.text!)")

 
 
        print("----------------------in EndEditing ends-----------------------")

        calculationDataTableView.reloadSections(indexSet, with: .automatic)




    }
    

    //MARK:Displaying result based on TextField

    func OutletTextInitializer (rows : Int) {
        
        for _ in 1...rows{
            textFieldDataContainer.append(0)
            
            
        }

    }
    
//    func SliderAction(){
////        print("--------------------in EndEditing--------------------------")
//        let reloadIndexPath : IndexPath = [0,cellRowAndTextFieldTag]
//        let reloadDPRateCell : IndexPath = [0,2]
//        let reloadDPCell: IndexPath = [0,1]
//        let sectionToReload =  1
//        let indexSet: IndexSet = [sectionToReload]
//
//
//
//        if cellRowAndTextFieldTag == 0 {
//
//            print ("*********************************** I'm in tag 0 *************************************")
//            textFieldReloader = String(sliderValue.value)
//            calculationDataTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
//
//
//
//            textFieldReloader = mortageCalculator.DownPaymentAndDownPaymentRateCalculator(homePrice: textFieldDataContainer[0], downPayment: textFieldDataContainer[1], downPaymentRate: nil)
//            calculationDataTableView.reloadRows(at: [reloadDPRateCell], with: .automatic)
//
//
//        } else if cellRowAndTextFieldTag == 1{
//
//            print ("*********************************** I'm in tag 1 ***************************************")
//            textFieldReloader = String(sliderValue.value)
//            calculationDataTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
//
//            textFieldReloader = mortageCalculator.DownPaymentAndDownPaymentRateCalculator(homePrice: textFieldDataContainer[0], downPayment: textFieldDataContainer[1], downPaymentRate: nil)
//            print("\(textFieldReloader)")
//            calculationDataTableView.reloadRows(at: [reloadDPRateCell], with: .automatic)
//
//        } else if cellRowAndTextFieldTag == 2{
//            print ("*********************************** I'm in tag 2 ***************************************")
//            textFieldReloader = String(sliderValue.value)
//            calculationDataTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
//
//            textFieldReloader = mortageCalculator.DownPaymentAndDownPaymentRateCalculator(homePrice: textFieldDataContainer[0], downPayment: nil, downPaymentRate: textFieldDataContainer[2])
//            calculationDataTableView.reloadRows(at: [reloadDPCell], with: .automatic)
//
//        } else {
//
//            print ("************************************* I'm in tag ELSE *******************************")
//            textFieldReloader = String(sliderValue.value)
//            calculationDataTableView.reloadRows(at: [reloadIndexPath], with: .automatic)
//        }
//
//
//
//
//
//
//
//
////        print("----------------------in EndEditing ends-----------------------")
//
//        calculationDataTableView.reloadSections(indexSet, with: .automatic)
//
//
//
//    }
//
//
    
}


