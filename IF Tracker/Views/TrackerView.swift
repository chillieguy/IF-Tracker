//
//  TrackerView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI
import CoreData

struct TrackerView: View {
    
    var timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var progressValue: Float = 0.0
    @State var fastInProgress: Bool = false
    @State var start: Date = Date.now
    @State var stop: Date = Date.now
    @State var selectedLength: Length = .twelve
    @State var fastCount: Int = 0
    @State var fastTime: String = "Update"
    

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Section("How many hours to fast:") {
                    Picker("Fasting Length", selection: $selectedLength) {
                        ForEach(Length.allCases) { length in
                            Text(length.title).tag(length)
                        }
                    }.pickerStyle(.segmented)
                }
                Text(fastInProgress ? "Fast Time: \(convertCountToTime(count: fastCount))" : "")
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
        .onAppear{
            if UserDefaults.standard.object(forKey: "fastStartTime") != nil {
                start = UserDefaults.standard.object(forKey: "fastStartTime") as! Date
            }
            if UserDefaults.standard.object(forKey: "fastInProgress") != nil {
                fastInProgress = UserDefaults.standard.bool(forKey: "fastInProgress")
            }
            
           
        }
        .onDisappear{
            
        }
        .onReceive(timer, perform: { _ in
            updateTime()
        })
    }
    
    private func convertCountToTime(count: Int) -> String {
        var countString = ""
        
        if(count < 60) {
            countString += "\(count) seconds"
        } else if(count < 3600) {
            countString += "\(count / 60) minutes \(count % 60) seconds"
        }
        
        return countString
    }
    
    private func updateTime() {
        var targetLength = Double(selectedLength.rawValue) ?? 0.0
        targetLength = targetLength * 3600
        let targetDate = start.addingTimeInterval(targetLength)
        
        let currentTimeCount = Int(Date.now.timeIntervalSince1970 - start.timeIntervalSince1970)
        let targetTimeCount = Int(targetDate.timeIntervalSince1970 - start.timeIntervalSince1970)
        
        fastTime = String(currentTimeCount)
        
//        print("Fasting Length: \(targetLength)")
//        print("Target Date: \(targetDate)")
//        print("Current Time Count: \(currentTimeCount)")
//        print("Target Time Count: \(targetTimeCount)")
        
        fastCount = currentTimeCount
        progressValue = Float(Double(currentTimeCount)/Double(targetTimeCount))
//        print("Progress Value: \(progressValue)")
    }
        
    private func handleButtonClick() {
        if (fastInProgress == true) {
            stop = Date.now
            saveFast()
            UserDefaults.standard.removeObject(forKey: "fastStartTime")
            UserDefaults.standard.set(false, forKey: "fastInProgress")
            
        } else {
            start = Date.now
            UserDefaults.standard.set(self.start, forKey: "fastStartTime")
            UserDefaults.standard.set(true, forKey: "fastInProgress")
        }
    }
    
    private func saveFast() {
        
        do{
            let fast = Fast(context: viewContext)
            fast.fastStart = start
            fast.fastEnd = stop
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
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

enum Length: String, Identifiable, CaseIterable{
    
    var id: UUID {
        return UUID()
    }
    
    case twelve = "12"
    case twentyfour = "24"
    case thirty = "30"
    case thirtysix = "36"
    case fortyeight = "48"
}

extension Length {
    var title: String{
        switch self {
        case .twelve:
            return "12"
        case .twentyfour:
            return "24"
        case .thirty:
            return "30"
        case .thirtysix:
            return "36"
        case .fortyeight:
            return "48"
        }
    }
}


struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView(fastCount: 12345)
    }
}

