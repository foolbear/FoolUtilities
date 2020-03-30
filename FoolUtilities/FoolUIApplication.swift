//
//  FoolUIApplication.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/3/30.
//

import UIKit

public extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
