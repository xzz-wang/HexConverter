//
//  HexConverter.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/12/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import Foundation

//
// This Class is designed to package all the logical code related with base
// Conversion
//

class HexConverter {
    
    
    // MARK: Most important type is defined here
    enum BaseTypes: String, Hashable, CaseIterable {
        case binary = "Binary"
        case octal = "Octal"
        case decimal = "Decimal"
        case hex = "Hexadecimal"
        
        func getBaseNum() -> Int {
            switch self {
            case .binary:
                return 2
            case .octal:
                return 8
            case .decimal:
                return 10
            case .hex:
                return 16
            }
        }
        
        func getName() -> String {
            switch self {
            case .binary:
                return "Binary"
            case .octal:
                return "Octal"
            case .decimal:
                return "Decimal"
            case .hex:
                return "Hexadecimal"
            }
        }
    }
    
    

    
    // Function Name: convert()
    // Description: Taking an integer and a base as a input, find the integer's expansion in the given base.
    static func convert(number: Int, toBase base: Int) -> String? {
        
        let digitOfNumber = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F",]
        
        
        // Error handling
        // When base is out of range
        if base > 16 || base < 2 {
            return nil
        }
        
        var result: String = ""
        var numberBuffer = number
        
        var i = 0 // Loop counter
        while numberBuffer != 0 {
            let thisDigit = numberBuffer % base
            
            // Add a space for every 4
            if i % 4 == 0 && i != 0 {
                result = " " + result
            }
            
            result = digitOfNumber[thisDigit] + result
            i += 1
            
            numberBuffer = numberBuffer / base
        }
        
        if result == "" {
            return "0"
        }
        
        return result
    }
    
    
    // Function name: convertFrom()
    // Description: get the decimal integer that is represented by the string in given base
    static func convertFrom(number:Substring, base: Int) -> Int! {
        
        // Local variables
        var digitsFromRight: Int = 0
        var workingSubstring: Substring = number
        var result = 0
        
        /* Error Checking Error Conditions */
        // Return nil if the input is problematic
        if base < 2 {
            print("The base is less than 2!")
            return nil;
        }
        
        // Generate the decimal
        while ( workingSubstring.count != 0 ) {
            
            let workingChar = workingSubstring.last!        // Get the last character
            let charValue: Int
            
            if workingChar.isHexDigit {
                charValue = workingChar.hexDigitValue!
            } else {
                // Error: not a hexDigit
                return nil
            }
            
            // Check two error conditions: char not in [0, Z]
            if charValue < base {
                
                // Noting is wrong
                result += Int(Double(charValue) * pow(Double(base), Double(digitsFromRight)))
                
            } else {
                // Error: The value is greater than base
                return nil
            }
            // Remove the right most character
            workingSubstring = workingSubstring.prefix(workingSubstring.count - 1)
            // Increment the decimal d
            digitsFromRight += 1
        }
        return result
    }

}
