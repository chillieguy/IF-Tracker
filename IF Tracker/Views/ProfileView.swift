//
//  ProfileView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

struct ProfileView: View {
    @State private var isShowingPrivacyPolicyView = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Privacy Policy"), isActive: $isShowingPrivacyPolicyView) { EmptyView() }
                Spacer()
                HStack {
                    Spacer()
                    Button("Privacy Policy") {
                        isShowingPrivacyPolicyView = true
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Profile")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func handleButton() {
        print("Pressed")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
