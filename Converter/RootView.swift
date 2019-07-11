//
//  RootView.swift
//  Converter
//
//  Created by 王雪铮 on 6/26/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import SwiftUI

struct RootView : View {
    var body: some View {
        TabbedView{
            NavigationView {
                ConverterView()
                    .navigationBarTitle(Text("Converter"), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {}, label: {Text("?")}))
                    .tabItem({Text("C")})
                    .tag(0)
            }
        }
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        Group{
            RootView()
                .previewDevice("iPhone XR")
            RootView()
                .previewDevice("iPhone 7")
        }
    }
}
#endif
