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
    
    @ObjectBinding var resultsObject: ConverterResults
    
    var body: some View {
        List{
            ForEach(resultsObject.results) { result in
                ResultCellView(result: result)
                .animation(.default)
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at index: IndexSet) {
        if let first = index.first {
            resultsObject.removeResult(at: first)
        }
    }
}

#if DEBUG
struct ResultView_Previews : PreviewProvider {
    static var previews: some View {
        ResultView(resultsObject: ConverterResults())
    }
}
#endif
