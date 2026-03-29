//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 3/29/26.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        // first responder resign is dismissing keyboard
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
