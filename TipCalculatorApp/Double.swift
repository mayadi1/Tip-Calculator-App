//
//  Double.swift
//  TipCalculatorApp
//
//  Created by Mohamed Ayadi on 8/7/17.
//  Copyright © 2017 com.ayadios. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
