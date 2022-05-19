//
//  TrackerView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI
import CoreData

struct TrackerView: View {
    
    // Init a timer to update every 1 second
    var timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    // Store a reference to the Coredata persistence container in the view
    @Environment(\.managedObjectContext) private var viewContext
    
    // Variables to capture fast progress and update the view
    @State var progressValue: Float = 0.0
    @State var fastInProgress: Bool = false
    @State var start: Date = Date.now
    @State var stop: Date = Date.now
    @State var selectedLength: Length = .twelve
    @State var fastCount: Int = 0
    @State var fastTime: String = "Update"
    

    var body: some View {
        NavigationView{
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
                    // Display field if fast currently inprogress
                    Text(fastInProgress ? "Fast Time: \(convertCountToTime(count: fastCount))" : "")
                    ProgressBar(progress: self.$progressValue)
                        .frame(width: 150.0, height: 150.0)
                        .padding(40.0)
                    
                    Button(action: {
                        self.handleButtonClick()
                        self.fastInProgress.toggle()
                    }) {
                        HStack {
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
                // Handle when view returns to focus
                if UserDefaults.standard.object(forKey: "fastStartTime") != nil {
                    start = UserDefaults.standard.object(forKey: "fastStartTime") as! Date
                }
                if UserDefaults.standard.object(forKey: "fastInProgress") != nil {
                    fastInProgress = UserDefaults.standard.bool(forKey: "fastInProgress")
                }
                
               
            }
            .onDisappear{
                
            }
            // Start the timer
            .onReceive(timer, perform: { _ in
                updateTime()
            })
            .navigationTitle("Tracking")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    /**
    Take a count in as an int and return string representation
     
     Input: Int
     
     Cutput: String
     */
    private func convertCountToTime(count: Int) -> String {
        var countString = ""
        
        if(count < 60) {
            countString += "\(count) seconds"
        } else if(count < 60 * 60) {
            if((count / 60) % 60 == 1) {
                countString += "\(count / 60) minute"
            } else {
                countString += "\(count / 60) minutes"
            }
        } else {
            if((count / 3600) % 3600 == 1) {
                countString += "\(count / 3600) hour and \((count / 60) % 60) minutes"
            } else {
            countString += "\(count / 3600) hours and \((count / 60) % 60) minutes"
            }
        }
        
        return countString
    }
    
    /**
    Update state variables with current time, target time if fast is inprogress
     */
    private func updateTime() {
        if(fastInProgress){
            var targetLength = Double(selectedLength.rawValue) ?? 0.0
            targetLength = targetLength * 3600
            let targetDate = start.addingTimeInterval(targetLength)
            
            let currentTimeCount = Int(Date.now.timeIntervalSince1970 - start.timeIntervalSince1970)
            let targetTimeCount = Int(targetDate.timeIntervalSince1970 - start.timeIntervalSince1970)
            
            fastTime = String(currentTimeCount)
            
            fastCount = currentTimeCount
            progressValue = Float(Double(currentTimeCount)/Double(targetTimeCount))
        } else {
            fastTime = ""
            fastCount = 0
            progressValue = 0
        }
    }
    
    /**
    Handle when the fast timer button is clicked.
     */
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
    
    /**
    Save the current fast into Coredata
     */
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


/**
 Subview to display the progress circle
 
 */
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

/**
 Enum to handle all of the fasting length options
 */
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

/**
 Return the string representation fo each fast length
 */
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

