//
//  ResultDetailView.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/13/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import SwiftUI

struct ResultDetailView : View {
    
    @ObjectBinding var result: ConverterResult
    
    @EnvironmentObject var resultsObject: ConverterResults
    @State var showAlert = false
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Base Type")
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(result.base.getName())")
                }
                
                HStack {
                    Text("Created Time")
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(result.createdTime.description)")
                }
                

            }

            Section(header: Text("Tap on results to copy")) {
                OutputRow(baseType: .binary, output: HexConverter.convert(number: result.value, toBase: 2)!)
                OutputRow(baseType: .octal, output: HexConverter.convert(number: result.value, toBase: 8)!)
                OutputRow(baseType: .decimal, output: HexConverter.convert(number: result.value, toBase: 10)!)
                OutputRow(baseType: .hex, output: HexConverter.convert(number: result.value, toBase: 16)!)
            }

        }
            .font(.body)
            .animation(.default)
            .navigationBarTitle(String(result.value))
            .listStyle(.grouped)
            .presentation($showAlert) {
                Alert(title: Text("This is deleted"), message: nil, dismissButton: .default(Text("Ok...")))
            }
    }
    
}

#if DEBUG
struct ResultDetailView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView{
            ResultDetailView(result: ConverterResult(of: 65, in: .binary))
                .environmentObject(ConverterResults(fromDisk: false))
        }
    }
}
#endif
