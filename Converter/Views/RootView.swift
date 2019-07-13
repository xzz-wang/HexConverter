//
//  RootView.swift
//  Converter
//
//  Created by 王雪铮 on 6/26/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import SwiftUI

struct RootView : View {
    @ObjectBinding var savedResults: ConverterResults
    
    var body: some View {
        TabbedView{
            
            // First View in the tabbed view
            NavigationView {
                ConverterView(savedResults: savedResults)
                    .navigationBarTitle(Text("Converter"), displayMode: .automatic)
            }
            .tag(0)
            .tabItem({
                VStack {
                    Image(systemName: "c.circle")
                    Text("Converter")
                }
            })
            
            
            // Second View
            NavigationView {
                ResultView(resultsObject: savedResults)
                    .navigationBarTitle(Text("Saved Results"), displayMode: .automatic)
            }
            .tag(1)
                .tabItem({
                    VStack {
                        Image(systemName: "r.circle")
                        Text("Saved Results")
                    }
                })


        }
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        Group{
            RootView(savedResults: ConverterResults())
                .previewDevice("iPhone XR")
        }
    }
}
#endif
