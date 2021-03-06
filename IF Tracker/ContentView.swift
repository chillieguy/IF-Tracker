//
//  MainView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            TrackerView()
                .tabItem{
                    Label("Track", systemImage: "timer")
                }
            InfoView()
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
