//
//  ContentView.swift
//  Converter
//
//  Created by 王雪铮 on 6/26/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import SwiftUI
import UIKit

struct ConverterView : View {
    
    // State variables
    @State var inputText: String = ""
    @State var inputBase = BaseTypes.decimal
    @State var showBasePicker = false
    @State var showCopiedAlert = false
    
    // Variable for detecting error
    var isError : Bool {
        get {
            if  convertFrom(number: Substring(inputText), base: baseNum) != nil{
                return false
            } else {
                return true
            }
        }
    }
    
    // Variables for calculation of the Results
    var baseNum: Int {get{
            return BASE_NUM_DIC[inputBase]!
        }}
    var workingNumber: Int {
        get {
            if let result = convertFrom(number: Substring(inputText), base: baseNum) {
                return result
            } else {
                return 0
            }
        }
    }
    
    var decimalOutput: String {get {
            return convert(number: workingNumber, toBase: 10)!
        }}
    var binaryOutput: String {get {
            return convert(number: workingNumber, toBase: 2)!
        }}
    var octalOutput: String {get {
            return convert(number: workingNumber, toBase: 8)!
        }}
    var hexOutput: String {get {
            return convert(number: workingNumber, toBase: 16)!
        }}
    
    
    // View Body
    var body: some View {
        
        VStack (alignment: .leading) {
            
            // First part of the view
            
            // First Row
            if isError {
                Text(" Error!!")
                .color(.red).bold()
                .animation(.spring())
            } else {
                Text(" \(inputBase.rawValue) Input:")
                .animation(.spring())
            }
            
            
            TextField("Your input goes here", text: $inputText)
                .padding(.all, 7)
                .border(Color.gray, width: 1, cornerRadius: 10)
                .animation(.spring())

            
            // Second Row: Button and pop-up picker
            Button(action: {
                self.showBasePicker.toggle()
            }) {
                Text(showBasePicker ?"Close Input Base" : "Choose Input Base")
                    .padding(.all, 7)
            }
                .background(showBasePicker ? Color.blue : Color.clear)
                .accentColor(showBasePicker ? Color.white : Color.blue)
                .cornerRadius(10)
                .animation(.spring())
            
            if showBasePicker {
                Divider()
                Picker(selection: $inputBase, label: Text("Input options")) {
                    Text("Binary").tag(BaseTypes.binary)
                    Text("Octal").tag(BaseTypes.octal)
                    Text("Decimal").tag(BaseTypes.decimal)
                    Text("Hex").tag(BaseTypes.hex)
                }
                .animation(.basic(duration: 0.5, curve: .easeInOut))
            }
            
            // Divider
            Divider()
                .animation(.spring())
            
            // For Output Rows
            OutputRow(baseType: .binary, output: getOutputString(of: .binary))
            OutputRow(baseType: .octal, output: getOutputString(of: .octal))
            OutputRow(baseType: .decimal, output: getOutputString(of: .decimal))
            OutputRow(baseType: .hex, output: getOutputString(of: .hex))

            
            Spacer()
        }
        .padding()
        
    }
    
    enum BaseTypes: String, Hashable, CaseIterable {
        case binary = "Binary"
        case octal = "Octal"
        case decimal = "Decimal"
        case hex = "Hex"
    }
    
    let ALL_BASES = [BaseTypes.binary, BaseTypes.octal, BaseTypes.decimal, BaseTypes.hex]
    
    let BASE_NUM_DIC = [ BaseTypes.binary: 2,
                       BaseTypes.octal : 8,
                       BaseTypes.decimal: 10,
                       BaseTypes.hex: 16]
    
    func getOutputString(of base: BaseTypes) -> String {
        switch base {
        case .binary:
            return binaryOutput
        case .decimal:
            return decimalOutput
        case .hex:
            return hexOutput
        case .octal:
            return octalOutput
        }
    }
}



#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ConverterView()
            ConverterView(showBasePicker: true)
        }
    }
}
#endif




// Function Name: convert()
// Description: Taking an integer and a base as a input, find the integer's expansion in the given base.
private func convert(number: Int, toBase base: Int) -> String? {
    
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
private func convertFrom(number:Substring, base: Int) -> Int! {
    
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

struct OutputRow : View {
    var baseType: ConverterView.BaseTypes
    var output: String
    @State var showAlert = false
    
    var body: some View {
        return HStack{
            Text("\(baseType.rawValue) Output:")
            Spacer()
            Text(output)
        }
        .padding(.top)
        .tapAction {
                UIPasteboard.general.string = self.output
                self.showAlert = true
        }
        .presentation($showAlert){
                Alert(title: Text("Result Copied!"), message: Text("The \(baseType.rawValue) result is copied to the clipboard!"), dismissButton: .default(Text("Got it!")))
        }
        .animation(.spring())
    }
}
