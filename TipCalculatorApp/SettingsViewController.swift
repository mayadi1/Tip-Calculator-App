//
//  SettingsViewController.swift
//  TipCalculatorApp
//
//  Created by Mohamed Ayadi on 8/7/17.
//  Copyright © 2017 com.ayadios. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var percentageAmountsTextFields: [UITextField]!
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.orange
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboard()
        let defaults = UserDefaults.standard
        let arrayValue = defaults.object(forKey: "tipPercentage") as! [Double]

        for i in 0..<3 {
            percentageAmountsTextFields[i].text = "\(arrayValue[i])"
        }
    }

    @IBAction func updateBtnPressed(_ sender: Any) {
        var tipPercentage = [Double]()
        let defaults = UserDefaults.standard
        
        for i in 0..<3 {
            tipPercentage.append(Double(percentageAmountsTextFields[i].text!)!)
        }
        defaults.set(tipPercentage, forKey: "tipPercentage")
        defaults.synchronize()
    }
}
