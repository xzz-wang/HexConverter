//
//  resultCellView.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/11/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import SwiftUI

struct ResultCellView : View {
    typealias BaseTypes = HexConverter.BaseTypes
    @State var result: ConverterResult
    @State var showDetail = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(result.value)")
                    .font(.body)
                
                    Spacer()
                
                    Text("in \(result.base.getName())")
                        .font(.caption)
            }
                .animation(.basic(duration: 0.5, curve: .easeInOut))
                .tapAction {
                    self.showDetail.toggle()
            }
            
            
            if showDetail {
                VStack(spacing: 0) {
                    OutputRow(baseType: .binary, output: HexConverter.convert(number: result.value, toBase: 2)!)
                    OutputRow(baseType: .octal, output: HexConverter.convert(number: result.value, toBase: 8)!)
                    OutputRow(baseType: .decimal, output: HexConverter.convert(number: result.value, toBase: 10)!)
                    OutputRow(baseType: .hex, output: HexConverter.convert(number: result.value, toBase: 16)!)
                }
                    .font(.footnote)
                    .padding(.vertical)
                    .animation(.basic(duration: 0.5, curve: .easeInOut))
                    //.border(Color.gray)
            }
        }
    }
}

#if DEBUG
struct resultCellView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ResultCellView(result: ConverterResult(of: 64, in: .binary))
            ResultCellView(result: ConverterResult(of: 64, in: .binary), showDetail: true)
        }
    }
}
#endif
