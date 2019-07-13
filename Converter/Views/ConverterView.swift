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
    
    typealias BaseTypes = HexConverter.BaseTypes
    
    // State variables
    @State var inputText: String = ""
    @State var inputBase = BaseTypes.decimal
    @State var showBasePicker = false
    @State var showCopiedAlert = false
    
    @EnvironmentObject var savedResults: ConverterResults
    
    // Variable for detecting error
    var isError : Bool {
        get {
            if  HexConverter.convertFrom(number: Substring(inputText), base: inputBase.getBaseNum()) != nil{
                return false
            } else {
                return true
            }
        }
    }
    

    var workingNumber: Int {
        get {
            if let result = HexConverter.convertFrom(number: Substring(inputText), base: inputBase.getBaseNum()) {
                return result
            } else {
                return 0
            }
        }
    }
    
    var decimalOutput: String {get {
            return HexConverter.convert(number: workingNumber, toBase: 10)!
        }}
    var binaryOutput: String {get {
            return HexConverter.convert(number: workingNumber, toBase: 2)!
        }}
    var octalOutput: String {get {
            return HexConverter.convert(number: workingNumber, toBase: 8)!
        }}
    var hexOutput: String {get {
            return HexConverter.convert(number: workingNumber, toBase: 16)!
        }}
    
    
    // MARK: - View Body
    var body: some View {
        
        VStack (alignment: .leading) {
            
            // First part of the view
            
            // First Row
            if isError {
                Text(" Error!!")
                .color(.red).bold()
                //.animation(.basic())
            } else {
                Text(" \(inputBase.rawValue) Input:")
                //.animation(.basic)
            }
            
            
            TextField("Your input goes here", text: $inputText)
                .padding(.all, 7)
                .border(Color.gray, width: 1, cornerRadius: 10)
                //.animation(.basic())

            
            // Second Row: Button and pop-up picker
            HStack {
                
                // Show picker button
                Button(action: {
                    self.showBasePicker.toggle()
                }) {
                    Text(showBasePicker ?"Close Input Base" : "Choose Input Base")
                        .padding(.all, 6)
                }
                .background(showBasePicker ? Color.blue : Color.clear)
                .accentColor(showBasePicker ? Color.white : Color.blue)
                .cornerRadius(10)
                //.animation(.basic())
                
                Spacer()
                
                // Save Information Button
                // TODO: Add action to the button
                Button("Save result", action: {
                    let newResult = ConverterResult(of: self.workingNumber, in: self.inputBase)
                    self.savedResults.addResult(newResult)
                })
                //.animation(.basic())
            }
            
            if showBasePicker {
                Divider()
                HStack {
                    Spacer()
                    Picker(selection: $inputBase, label: Text("Input options")) {
                        Text("Binary").tag(BaseTypes.binary)
                        Text("Octal").tag(BaseTypes.octal)
                        Text("Decimal").tag(BaseTypes.decimal)
                        Text("Hex").tag(BaseTypes.hex)
                    }
                    .animation(.basic(duration: 0.5, curve: .easeInOut))
                    Spacer()
                }
            }
            
            // Divider
            Divider()
                .animation(.basic())
            
            // For Output Rows
            Group{
                OutputRow(baseType: .binary, output: getOutputString(of: .binary))
                OutputRow(baseType: .octal, output: getOutputString(of: .octal))
                OutputRow(baseType: .decimal, output: getOutputString(of: .decimal))
                OutputRow(baseType: .hex, output: getOutputString(of: .hex))
            }
            .padding(.top)
            .animation(.basic())

            
            Spacer()
        }
        .padding()
        .animation(.spring())
        
    }
    
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
                .environmentObject(ConverterResults(fromDisk: false))
        }
    }
}
#endif


