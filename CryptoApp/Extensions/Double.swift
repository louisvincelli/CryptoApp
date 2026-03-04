//
//  Double.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 2/19/26.
//

import Foundation

extension Double {
    
    /// Converts a Double into a Currency with 2 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true // get rid of commas
        formatter.numberStyle = .currency
        //formatter.locale = .current // locale is usd < Default value
        //formatter.currencyCode = "USD" // <- Change currency
        //formatter.currencySymbol = "$" // <- Change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double into a Currency as a String with 2 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// ```
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value:self)
        //return currencyFormatter6.string(from: NSNumber(value: self)) ?? "$0.00"
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true // get rid of commas
        formatter.numberStyle = .currency
        //formatter.locale = .current // locale is usd < Default value
        //formatter.currencyCode = "USD" // <- Change currency
        //formatter.currencySymbol = "$" // <- Change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a Double into a Currency as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value:self)
        //return currencyFormatter6.string(from: NSNumber(value: self)) ?? "$0.00"
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into a String representation
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into a String representation with percent symbol
    /// ```
    /// Convert 1.2345 to "1.23%"
    /// ```
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}
