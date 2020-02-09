//
//  Helpers.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Double {
    func toString(format: String) -> String {
        return String(format: "%\(format)f",self)
    }
    
    func toInt() -> Int? {
        let minInt = Double(Int.min)
        let maxInt = Double(Int.max)

        guard case minInt ... maxInt = self else {
            return nil
        }

        return Int(self)
    }
    
    func toRadians() -> Double {
        return self * .pi / 180
    }
}

extension String {
    func replaceComma() -> String {
        return self.replacingOccurrences(of: ",", with: ".")
    }
}

