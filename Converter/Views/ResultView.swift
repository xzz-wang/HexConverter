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
        List{
            ForEach(results) { result in
                ResultCellView(result: result)
                .animation(.default)
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at index: IndexSet) {
        if let first = index.first {
            results.remove(at: first)
        }
    }
}

#if DEBUG
struct ResultView_Previews : PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
#endif
