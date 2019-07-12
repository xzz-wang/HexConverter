//
//  ResultView.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/12/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import SwiftUI

struct ResultView : View {
    typealias BaseTypes = HexConverter.BaseTypes
    
    @State var results = [ConverterResult(of: 64, in: .binary), ConverterResult(of: 64, in: .hex)]
    
    var body: some View {
        List (self.results) { result in            ResultCellView(result: result)
        }.animation(.basic(duration: 0.5, curve: .easeInOut))
    }
}

#if DEBUG
struct ResultView_Previews : PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
#endif


public class ConverterResult: Identifiable {
    var value: Int
    var base: HexConverter.BaseTypes
    
    init(of value: Int, in base: HexConverter.BaseTypes) {
        self.value = value
        self.base = base
    }
}
