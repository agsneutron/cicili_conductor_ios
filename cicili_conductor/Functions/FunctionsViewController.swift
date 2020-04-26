//
//  FunctionsViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 25/04/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit


class FunctionsApp: NSObject {
      
    

    class func currencyFormat(tipAmount : NSNumber, txtObject : UILabel, etiqueta: String){
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: tipAmount as NSNumber) {
            txtObject.text = "\(etiqueta) \(formattedTipAmount)"
        }
    }
    class func decimalFormat(tipAmount : NSNumber, txtObject : UILabel, etiqueta: String){
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .decimal
        if let formattedTipAmount = formatter.string(from: tipAmount as NSNumber) {
            txtObject.text = "\(etiqueta) \(formattedTipAmount)"
        }
    }

}
