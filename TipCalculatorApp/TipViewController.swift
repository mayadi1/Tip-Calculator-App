//
//  ViewController.swift
//  TipCalculatorApp
//
//  Created by Mohamed Ayadi on 8/7/17.
//  Copyright © 2017 com.ayadios. All rights reserved.
//

import UIKit

class TipViewController: UIViewController{

    @IBOutlet var tipResults: [UILabel]!
    @IBOutlet weak var billTextField: UITextField!
    var tipPercentage: [Double] = [0.15,0.20,0.25]
    
    @IBOutlet weak var customTipPercentLabel: UILabel!
    @IBOutlet weak var customTipResultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        billTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    func textFieldDidChange(_ textField: UITextField) {
        updateTipResults()
    }
    
    func updateTipResults(){
        if(!(billTextField.text?.isEmpty)!){
            for i in 0..<3 {
                tipResults[i].text = "\((Double(billTextField.text!)! * tipPercentage[i]).roundTo(places: 2))"
            }
        }else{
            for i in 0..<3 {
                tipResults[i].text = "0"
            }
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = Double(sender.value).roundTo(places: 2)
        customTipPercentLabel.text = "\(currentValue)"
        customTipResultLabel.text = "\((Double(billTextField.text!)! * currentValue).roundTo(places: 2))"
    }
}

