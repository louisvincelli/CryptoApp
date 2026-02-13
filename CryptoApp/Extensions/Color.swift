//
//  Color.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 2/12/26.
//

// Extending the Color class

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}

// can create new struct ColorTheme2 for testing new color theme in app
