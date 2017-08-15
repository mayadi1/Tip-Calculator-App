//
//  ViewController.swift
//  TipCalculatorApp
//
//  Created by Mohamed Ayadi on 8/7/17.
//  Copyright © 2017 com.ayadios. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var tipResults: [UILabel]!
    @IBOutlet weak var billTextField: UITextField!
    var tipPercentage: [Double] = [15,20,25]
    var customTipPercentLabelValue : Double = 30
    @IBOutlet weak var customTipPercentLabel: UILabel!
    @IBOutlet weak var customTipResultLabel: UILabel!
    @IBOutlet var tipPercentLabels: [UILabel]!
    @IBOutlet var totalValuesLabels: [UILabel]!
    @IBOutlet weak var resultsView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
         let defaults = UserDefaults.standard
        if let savedDate = UserDefaults.standard.object(forKey: "disappearTime") as? Date{
            let calendar = Calendar.current
            let date = Date()
            let currentYear = calendar.component(.year, from: date)
            let currentMonth = calendar.component(.month, from: date)
            let currentDay = calendar.component(.day, from: date)
            let currentHour = calendar.component(.hour, from: date)
            let currentMinutes = calendar.component(.minute, from: date)
            let savedYear = calendar.component(.year, from: savedDate)
            let savedMonth = calendar.component(.month, from: savedDate)
            let savedDay = calendar.component(.day, from: savedDate)
            let savedHour = calendar.component(.hour, from: savedDate)
            let savedMinutes = calendar.component(.minute, from: savedDate)
            if(currentYear == savedYear && currentMonth == savedMonth &&  currentDay == savedDay && currentHour == savedHour && currentMinutes <= (savedMinutes + 10)){
                let defaults = UserDefaults.standard
                let billValue = defaults.object(forKey: "billValue") as! Double
                billTextField.text = String(billValue)
                updateTipResults()
            }
        }

        
        if(defaults.object(forKey: "tipPercentage") as? [Double] != nil){
            tipPercentage = (defaults.object(forKey: "tipPercentage") as? [Double])!
            setTipPercentLables()
            self.billTextField.becomeFirstResponder()
         }else{
            self.billTextField.becomeFirstResponder()
            setTipPercentLables()
            defaults.set(tipPercentage, forKey: "tipPercentage")
            defaults.synchronize()
         }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsView.layer.cornerRadius = 10
        self.hideKeyboard()
        billTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
         if(!(billTextField.text?.isEmpty)!){
            UserDefaults.standard.set(Date(), forKey: "disappearTime")
            let defaults = UserDefaults.standard
            defaults.set(Double(billTextField.text!)!, forKey: "billValue")
            defaults.synchronize()
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        updateTipResults()
    }
    
    func updateTipResults(){
        if(!(billTextField.text?.isEmpty)!){
            UserDefaults.standard.set(Date(), forKey: "disappearTime")
            for i in 0..<3 {
                tipResults[i].text = "$\((Double(billTextField.text!)! * (tipPercentage[i] / 100)).roundTo(places: 2))"
                customTipResultLabel.text = "$\((Double(billTextField.text!)! * (customTipPercentLabelValue / 100)).roundTo(places: 2))"
                totalValuesLabels[i].text = "$\((Double(billTextField.text!)! * (tipPercentage[i] / 100) + Double(billTextField.text!)!).roundTo(places: 2))"
            }
            totalValuesLabels.last?.text = "$\((Double(billTextField.text!)! * (customTipPercentLabelValue / 100) + Double(billTextField.text!)!).roundTo(places: 2))"
        }else{
            for i in 0..<3 {
                tipResults[i].text = "0"
                customTipResultLabel.text = "$0"
                totalValuesLabels[i].text = "$0"
            }
            totalValuesLabels.last?.text = "$0"
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = Double(sender.value).roundTo(places: 2)
        customTipPercentLabel.text = "\(currentValue)%"
        self.customTipPercentLabelValue = currentValue
        if(!(billTextField.text?.isEmpty)!){
            customTipResultLabel.text = "$\((Double(billTextField.text!)! * (currentValue / 100)).roundTo(places: 2))"
            totalValuesLabels.last?.text = "$\((Double(billTextField.text!)! * (customTipPercentLabelValue / 100) + Double(billTextField.text!)!).roundTo(places: 2))"
        }
    }
    
    func setTipPercentLables(){
        for i in 0..<3 {
            tipPercentLabels[i].text = "\(tipPercentage[i])%"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(Date(), forKey: "disappearTime")
    }
}

