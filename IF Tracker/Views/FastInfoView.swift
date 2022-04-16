//
//  FastInfoView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 1/29/22.
//

import SwiftUI


struct FastInfoView: View {
    
    @Binding var fastsInfo: FastsInfo

        var body: some View {
            HStack {
                VStack(alignment: .center, spacing: 8) {
                    Text(fastsInfo.name)
                        .font(.title)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(fastsInfo.summary)
                        .font(.body)
                }
//                Image(fastsInfo.imageName)
//                    .resizable()
//                    .frame(width: 100, height: 100)
            }
            .padding()
        }
}
