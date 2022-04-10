//
//  ProfileView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        GroupBox{
            Text("Profile View")
        } label: {
            Label("Profile View", systemImage: "music.note")
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
