//
//  ProfileView.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI

struct ProfileView: View {
    @State private var isShowingPrivacyPolicyView = false
    @State private var name = ""
    @State private var birthDate = Date()
    @State private var weight = ""
    
    // Store a reference to the Coredata persistence container in the view
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch request to handle retrieving data from Coredata
//    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: false)]) private var user: FetchedResults<User>
    
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Privacy Policy"), isActive: $isShowingPrivacyPolicyView) { EmptyView() }
                Form{
                    Section(header: Text("Name")){
                        TextField("Name:", text: $name)
                            .submitLabel(.return)
                    }
                    Section(header: Text("Birthdate")){
                        Text("Enter your birthday")
                                        .font(.largeTitle)
                        DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                                        Text("Select a date")
                                    }
                    }
                    Section(header: Text("Weight")){
                        TextField("Weight:", text: $weight)
                            .keyboardType(.decimalPad)
                            .submitLabel(.return)
                    }
                }
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
            .toolbar {
                Button("Save") {
                    saveProfile()
                }
            }
            .onAppear {
                name = user.first?.name ?? ""
                birthDate = user.first?.birthdate ?? Date.now
                weight = user.first?.weight ?? ""
                
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func handleButton() {
        saveProfile()
    }
    
    private func saveProfile() {
        
        do{
            let user = User(context: viewContext)
            user.name = name
            user.birthdate = birthDate
            user.weight = weight
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
