//
//  ContactUs.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-03-27.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit
import MessageUI

class ContactUs: UIViewController, MFMailComposeViewControllerDelegate{

    @IBAction func CallNumber(_ sender: Any) {
        let phoneNumber = "6473521328"
        let url = URL(string: "telprompt://\(phoneNumber)")
        UIApplication.shared.open(url!)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("item 3 loaded")
    }
    

    func configureMailController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["wuchufan7@gmail.com"])
        mailComposerVC.setSubject("Test")
        
        return mailComposerVC
    }
    
    func showMailError(){
        
        let sendMailErrorAlert = UIAlertController(title: "Could not send mail", message: "Your device could not send email", preferredStyle: .alert)
        
        let dismiss = UIAlertAction(title: "Fine", style: .default, handler: nil)
        
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
