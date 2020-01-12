//
//  Extensions.swift
//  CubicWeight_Challenge
//
//  Created by iOS Developer on 1/12/20.
//  Copyright © 2020 kogan. All rights reserved.
//

import Foundation
import UIKit
extension Float {
    
    /// Round the float number to decimal
    /// - Parameter fractionDigits: number of digits
    func roundToDecimal(_ fractionDigits: Int) -> Float {
        let multiplier = pow(10, Float(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}



extension UIViewController {
    
    /// Display alert view controller
    /// - Parameters:
    ///   - title: The alert title
    ///   - message: The alert message
    ///   - okButtonTitle: The title of button
    func alert(title: String, message: String, okButtonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tag = 7777
        let actionOk = UIAlertAction(title: okButtonTitle,
                                     style: .default,
                                     handler: nil)
        
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
}
