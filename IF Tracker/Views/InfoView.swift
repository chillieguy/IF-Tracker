//
//  InfoView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

struct InfoView: View {
    
    @State var fastsInfos: [FastsInfo]

        var body: some View {
            NavigationView{
                List(fastsInfos.indices, id: \.self) { itemIndex in
                    ZStack {
                        NavigationLink(destination: FastInfoDetailView(fastsInfo: self.$fastsInfos[itemIndex])) {
                        }
                        .opacity(0)
                        CardListRow(fastsInfo: self.$fastsInfos[itemIndex])
                    }
                    
                }
                .padding(EdgeInsets(top: 44, leading: 0, bottom: 24, trailing: 0))
                .navigationTitle("Fasting Info")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(fastsInfos: FastsInfo.data)
    }
}

/**
 Subview to act as a container for each list item
 */
struct CardListRow: View {
    @Binding var fastsInfo: FastsInfo

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .cornerRadius(12)
            FastInfoView(fastsInfo: $fastsInfo)
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

/**
 New view to display the info when a list item is selected
 */
struct FastInfoDetailView: View {
    @Binding var fastsInfo: FastsInfo
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .cornerRadius(12)
            FastInfoView(fastsInfo: $fastsInfo)
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
