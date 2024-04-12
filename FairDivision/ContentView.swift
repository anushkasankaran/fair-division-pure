//
//  ContentView.swift
//  FairDivision
//
//  Created by Srikar on 2/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection) {
            TasksInput(selection: $selection)
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                }
                .tag(1)
            
            LandingChoice(selection: $selection)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(2)
            
            GoodsInput(selection: $selection)
                .tabItem {
                    Image(systemName: "cart")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
