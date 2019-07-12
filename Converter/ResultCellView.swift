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
    @State var value = (64, BaseTypes.decimal)
    @State var showDetail = true
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(value.0)")
                    .font(.body)
                
                    Spacer()
                
                    Text("in \(value.1.getName())")
                        .font(.caption)
            }
                .padding()
                .animation(.basic(duration: 0.5, curve: .easeInOut))
                .tapAction {
                    self.showDetail.toggle()
            }
            
            
            if showDetail {
                VStack(spacing: 0) {
                    OutputRow(baseType: .binary, output: HexConverter.convert(number: value.0, toBase: 2)!)
                    OutputRow(baseType: .octal, output: HexConverter.convert(number: value.0, toBase: 8)!)
                    OutputRow(baseType: .decimal, output: HexConverter.convert(number: value.0, toBase: 10)!)
                    OutputRow(baseType: .hex, output: HexConverter.convert(number: value.0, toBase: 16)!)
                }
                    .font(.footnote)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .animation(.basic(duration: 0.5, curve: .easeInOut))
                    .border(Color.gray)
            }
        }
    }
}

#if DEBUG
struct resultCellView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ResultCellView()
            ResultCellView(showDetail: true)
        }
    }
}
#endif
