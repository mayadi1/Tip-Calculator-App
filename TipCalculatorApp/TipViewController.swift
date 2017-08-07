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
    var tipPercentage: [Double] = [15,20,25]
    var customTipPercentLabelValue : Double = 30
    @IBOutlet weak var customTipPercentLabel: UILabel!
    @IBOutlet weak var customTipResultLabel: UILabel!
    @IBOutlet var tipPercentLabels: [UILabel]!
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if(defaults.object(forKey: "tipPercentage") as? [Double] != nil){
            tipPercentage = (defaults.object(forKey: "tipPercentage") as? [Double])!
            setTipPercentLables()
        }else{
            setTipPercentLables()
            defaults.set(tipPercentage, forKey: "tipPercentage")
            defaults.synchronize()
        }
    }
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
                tipResults[i].text = "$\((Double(billTextField.text!)! * (tipPercentage[i] / 100)).roundTo(places: 2))"
                customTipResultLabel.text = "$\((Double(billTextField.text!)! * (customTipPercentLabelValue / 100)).roundTo(places: 2))"
            }
        }else{
            for i in 0..<3 {
                tipResults[i].text = "0"
                customTipResultLabel.text = "$0"
            }
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = Double(sender.value).roundTo(places: 2)
        customTipPercentLabel.text = "\(currentValue)%"
        self.customTipPercentLabelValue = currentValue
        if(!(billTextField.text?.isEmpty)!){
            customTipResultLabel.text = "$\((Double(billTextField.text!)! * (currentValue / 100)).roundTo(places: 2))"
        }
    }
    
    func setTipPercentLables(){
        for i in 0..<3 {
            tipPercentLabels[i].text = "\(tipPercentage[i])%"
        }
    }
}

