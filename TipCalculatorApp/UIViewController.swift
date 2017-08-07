//
//  UIViewController.swift
//  TipCalculatorApp
//
//  Created by Mohamed Ayadi on 8/7/17.
//  Copyright © 2017 com.ayadios. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
