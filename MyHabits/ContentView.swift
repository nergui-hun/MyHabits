//
//  ContentView.swift
//  MyHabits
//
//  Created by M M on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HabitsView()
                .tabItem { Label("habits", systemImage: "rectangle.grid.1x2.fill") }
       
            InfoView()
                .tabItem { Label("Info", systemImage: "info.circle.fill") }
        }
    }
}

#Preview {
    ContentView()
}
