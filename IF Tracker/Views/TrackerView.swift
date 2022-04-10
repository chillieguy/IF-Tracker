//
//  TrackerView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

struct TrackerView: View {
    @State var progressValue: Float = 0.0
    @State var fastInProgress: Bool = false
    @State var start: Date?
    @State var stop: Date?
    @State var fastTime: String = "1 hour"
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(fastInProgress ? "Fast Time: \(fastTime)" : "")
                ProgressBar(progress: self.$progressValue)
                    .frame(width: 150.0, height: 150.0)
                    .padding(40.0)
                
                Button(action: {
                    self.handleButtonClick()
                    self.fastInProgress.toggle()
                }) {
                    HStack {
//                        Image(systemName: "plus.rectangle.fill")
                        Text(fastInProgress ? "Complete Fast" : "Start Fast")
                    }
                    .padding(15.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(lineWidth: 2.0)
                    )
                }
                
                Spacer()
            }
        }
    }
    
    func handleButtonClick() {
        if (fastInProgress == true) {
            stop = Date.now
        } else {
            start = Date.now
        }
    }
}



struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    }
}

