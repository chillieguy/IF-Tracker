//
//  MainView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

/**
 Handles the setup and initial tabbar setup of the app
 and the start animation
 */

struct MainView: View {
    
    @State private var animationState: AnimationState = .normal
    @State private var done: Bool = false
    
    enum AnimationState {
        case compress
        case expand
        case normal
    }
    
    // Handle the compression or expantion of the logo
    func calculate() -> Double {
        switch animationState {
            case .compress:
                return 0.18
            case .expand:
                return 10.0
            case .normal:
                return 0.2
        }
    }
    
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
            .scaleEffect(done ? 1: 0.95)
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(calculate())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 81/255, green: 105/255, blue: 99/255))
            .opacity(done ? 0 : 1)
             
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring()) {
                    animationState = .compress
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring()) {
                            animationState = .expand
                            withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0)) {
                                done = true
                            }
                        }
                    }
                }
            }
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
