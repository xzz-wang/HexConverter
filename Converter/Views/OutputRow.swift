//
//  OutputRow.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/12/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import SwiftUI

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
        .tapAction {
            UIPasteboard.general.string = self.output
            self.showAlert = true
        }
        .presentation($showAlert){
            Alert(title: Text("Result Copied!"), message: Text("The \(baseType.rawValue) result is copied to the clipboard!"), dismissButton: .default(Text("Got it!")))
        }
    }
}

#if DEBUG
struct outputRow_Previews : PreviewProvider {
    static var previews: some View {
        OutputRow(baseType: .decimal, output: "10010101")
    }
}
#endif
