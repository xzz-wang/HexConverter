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
    
    @EnvironmentObject var resultsObject: ConverterResults
    
    var body: some View {
        NavigationView {
            List{
                ForEach(resultsObject.results) { result in
                    ResultCellView(result: result)
                        .animation(.default)
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitle(Text("Saved Results"), displayMode: .automatic)
            .navigationBarItems(trailing: EditButton())
            .animation(.default)
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
        ResultView()
            .environmentObject(ConverterResults(fromDisk: false))
    }
}
#endif
