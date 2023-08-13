//
//  Double.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import Foundation

extension Double {
    //MARK: currencyFormatter2
    /// Converts Double types to formatted Currency type with 2 decimal places
    /// ```
    /// Examples:
    /// Convert 1234.56 to $1234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    //MARK: asCurrencyWithTwoDecimals
    /// Returns a string containing the formatted value to 2 decimal places of the Double provided
    /// ```
    /// Examples:
    /// Convert 1234.56 to "$1234.56"
    /// ```
    /// - Returns: A string containing the formatted value of number using the receiver’s current settings.
    func asCurrencyWithTwoDecimals() -> String {
        
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }

    //MARK: currencyFormatter6
    /// Converts Double types to formatted Currency type with 2 - 6 decimal places
    /// ```
    /// Examples:
    /// Convert 1234.56 to $1234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    //MARK: asCurrencyWithSixDecimals
    /// Returns a string containing the formatted value of the Double provided
    /// ```
    /// Examples:
    /// Convert 1234.56 to "$1234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    /// - Returns: A string containing the formatted value of number using the receiver’s current settings.
    func asCurrencyWithSixDecimals() -> String {
        
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    //MARK: asNumberString
    /// Returns a string representation of a double with 2 decimal places
    /// ```
    /// Examples:
    /// Convert 1.23456 to "1.234"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    //MARK: asPercentageString
    /// Returns a string representation of a double with percentage symbol
    /// ```
    /// Examples:
    /// Convert 1.23456 to "1.23%"
    /// ```
    func asPercentageString() -> String {
        return asNumberString() + "%"
    }
    
    //MARK: formattedWithAbbreviations
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }

    
}
