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
    
    @ObjectBinding var result: ConverterResult
    
    var body: some View {
        
        return VStack(spacing: 0) {
            HStack {
                Text("\(HexConverter.convert(number: result.value, toBase: result.base.getBaseNum())!)")
                    .font(.body)
                    .color(Color.primary)
                
                    Spacer()
                
                    Text("in \(result.base.getName())")
                        .font(.caption)
                        .color(Color.primary)
                }
        }
    }
}


#if DEBUG
struct resultCellView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ResultCellView(result: ConverterResult(of: 64, in: .octal))
            NavigationView {
                ResultDetailView(result: ConverterResult(of: 64, in: .octal))
            }
        }
    }
}
#endif
