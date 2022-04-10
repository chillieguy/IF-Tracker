//
//  MainView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        ZStack {
            TabView{
                TrackerView()
                    .tabItem{
                        Label("Track", systemImage: "timer")
                    }
                InfoView(fastsInfos: FastsInfo.data)
                    .tabItem{
                        Label("Info", systemImage: "info")
                    }
                HistroyView()
                    .tabItem{
                        Label("History", systemImage: "list.dash")
                    }
                ProfileView()
                    .tabItem{
                        Label("Profile", systemImage: "person")
                    }
            }
            .accentColor(.primary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .preferredColorScheme(.light)
                .previewDevice("iPhone 12")
            MainView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 12")
        }
    }
}
