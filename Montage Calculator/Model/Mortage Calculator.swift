//
//  Mortage Calculator.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-03-07.
//  Copyright © 2019 TIEC. All rights reserved.
//

import Foundation

class MortageCalculator {
    

//    var downPayment = 0.0
//    var homePrice = 0.0
//
//    var downPaymentRate = 0.0
//    var interestRate = 0.0
//    var totalInterestRate = 0.0
//    var Amortization = 0
    

    func MonthlyCalculator (_ downPayment : Double,_ downPaymentRate : Double,_ homePrice : Double,_ interestRate : Double,_ amortization : Double,_ operation: String) -> String{
        
//        let downPayment = homePrice * downPaymentRate
//        let downPaymentRate = homePrice / downPayment
        var paymentNumberParameter = 0.0
        
        if operation == "monthly" {
            
            paymentNumberParameter = 12.0
            
        } else if operation == "bi-weekly" {
            
            paymentNumberParameter = 26.0
            
        } else if operation == "weekly" {
            
            paymentNumberParameter = 52.0
        }
        
        let monthlyRate = interestRate / paymentNumberParameter
        let paymentNumber = amortization * paymentNumberParameter
        let totalInterestRate = pow((1 + monthlyRate),Double(paymentNumber))
        let alpha = monthlyRate * totalInterestRate / (totalInterestRate - 1)
        let loan = homePrice - downPayment
        
        
        if (alpha * loan).isNaN || (alpha * loan).isInfinite {
            return String("N/A")
        } else {
            return "$" + String(ChangeNumberToTwoDigits(Number : alpha * loan))
        }
//        print("------------------------Calculation Values---------------------")
//        print("monthlyRate: \(monthlyRate)")
//        print("paymentNumber: \(paymentNumber)")
//        print("totalInterestRate: \(totalInterestRate)")
//        print("alpha: \(alpha)")
//        print("downPayment : \(downPayment)")
//      print("downPaymentRate: \(downPaymentRate)")
//        print("------------------------Calculation Values Ends--------------------")
        

    }
    
    func DownPaymentAndDownPaymentRateCalculator (homePrice : Double, downPayment : Double?, downPaymentRate : Double?) -> String {
        var returnDownPayment : Double = 0.0
        var returnDownPaymentRate : Double = 0.0
        
        if downPayment != nil {
            returnDownPaymentRate = downPayment! / homePrice
            
            if returnDownPaymentRate.isNaN || returnDownPaymentRate.isInfinite{
                
                return String("N/A")
            } else {
                
                return String(ChangeNumberToTwoDigits(Number : returnDownPaymentRate * 100))
            }


            
        } else {
            returnDownPayment =  homePrice * (downPaymentRate! / 100)
            if returnDownPayment.isNaN || returnDownPayment.isInfinite{
                
                return String("N/A")
            } else {
                
                returnDownPayment =  homePrice * (downPaymentRate! / 100)
                return String(Int(ChangeNumberToTwoDigits(Number: returnDownPayment)))
            }

            
            
            
        }
        
        
    }
    
    func ChangeNumberToTwoDigits (Number : Double) -> Double{
        
        return (Number * 100).rounded() / 100
    }

    func PsudoCalculator (homePrice : Double, downPayment : Double, Loan : Double) -> String{
        return String(homePrice + downPayment + Loan)
    }

}
