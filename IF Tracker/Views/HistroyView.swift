//
//  HistroyView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

struct HistroyView: View {
    
    // Store a reference to the Coredata persistence container in the view
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch request to handle retrieving data from Coredata
    @FetchRequest(entity: Fast.entity(), sortDescriptors: [NSSortDescriptor(key: "fastStart", ascending: false)]) private var allFasts: FetchedResults<Fast>
    
    let dateFormatter: DateFormatter
    
    // Init dateformatter when view is created
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(allFasts) { fast in
                    // Check that the entity has a non nil start and end value
                    if let start = fast.fastStart, let end = fast.fastEnd {
                        
                        ZStack {
                            Color(UIColor.systemBackground)
                                .cornerRadius(12)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(start, style: .date)
                                        .font(.title)
                                        .fixedSize(horizontal: false, vertical: true)
                                    HStack{
                                        Text("Start: ")
                                        Text(start, style: .time)
                                            .font(.body)
                                    }
                                    HStack{
                                        Text("End: ")
                                        let diff =  Calendar.current.dateComponents([.day], from:start, to: end)
                                        if(diff.day == 0) {
                                            Text(end, style: .time)
                                                .font(.body)
                                        } else {
                                            Text(end, style: .date)
                                                .font(.body)
                                        }
                                        
                                    }
                                    
                                }
                            Spacer()
                                // TODO - Add total fast time
                                let time = Int(end.timeIntervalSince(start))
                                Text("\(time / 3600) Hours")
                            }
                            .padding()
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    }
                    
                }
                // Handle delete swipe of list items
                .onDelete(perform: deleteFast)
            }
            .navigationTitle("History")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    /**
    Delete the item at index in list
     
     Input: index
     */
    private func deleteFast(at offsets: IndexSet) {
        offsets.forEach {index in
            let fast = allFasts[index]
            viewContext.delete(fast)
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct HistroyView_Previews: PreviewProvider {
    static var previews: some View {
        HistroyView()
    }
}
