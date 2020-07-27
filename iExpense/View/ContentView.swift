//
//  ContentView.swift
//  iExpense
//
//  Created by Gavin Butler on 26-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type.rawValue)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Object data Persistence with User Defaults - saving & retrieving:
/*struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "", lastName: "")
    @State private var loaded = false
    @State private var saved = false
    
    let decoder = JSONDecoder()
    
    var body: some View {
        VStack {
            TextField("FirstName", text: $user.firstName)
                .background(Color.blue)
                .foregroundColor(.white)
            TextField("LastName", text: $user.lastName)
                .background(Color.blue)
                .foregroundColor(.white)
            Button("save User") {
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                    self.saved = true
                }
            }
            Button("Blank User") {
                self.user = User(firstName: "", lastName: "")
            }
            Button("get User") {
                let decoder = JSONDecoder()
                if let data = UserDefaults.standard.data(forKey: "UserData"), let loadedUser = try? decoder.decode(User.self, from: data) {
                    self.user = loadedUser
                    self.loaded = true
                }
            }
            
            Text("Loaded is: \(loaded.description)")
            Text("Saved is: \(saved.description)")
            Text("UserFirstName: \(user.firstName)")
            Text("UserLastName: \(user.lastName)")
        }
    }
}*/

//Object data Persistence with User Defaults - saving only:
/*struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Gavin", lastName: "Butler")
    
    let decoder = JSONDecoder()
    
    var body: some View {
        VStack {
            Button("save User") {
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
            
        }
    }
}*/

//Simple data Persistence with User Defaults:
/*struct ContentView: View {
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "TapCount")
    
    var body: some View {
        VStack {
            Button("TapCount: \(tapCount)") {
                self.tapCount += 1
                UserDefaults.standard.set(self.tapCount, forKey: "TapCount")
            }
        }
    }
}*/

//Deleting items using onDelete():
/*struct ContentView: View {
    
    @State private var numbers: [Int] = []
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                .onDelete(perform: removeRows)
                }
                Button("Tap to add") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())  //Not really required - adds edit/delete functionality to the navigation bar
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}*/

//Showing another view using .sheet, a binding to toggle it on/off, and an @Environment variable on the second view to allow for the second view to programmatically dismiss itself (rather than relying on the default behaviour of the user swiping it down:
/*struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var viewTitle: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .green]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            RadialGradient(gradient: Gradient(colors: [.white, .green]), center: .bottom, startRadius: 0, endRadius: 720).edgesIgnoringSafeArea(.all)
            VStack {
                Text(viewTitle)
                Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ContentView: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Text("Tap the button below")
            Button("Show Sheet") {
                self.showingSheet.toggle()
            }
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(viewTitle: "Second sheeeet")
        }
    }
}*/

//Conform class to ObservableObject protocol, wrap class variables with @Published, use @ObservedObject wrapper on class instance:
/*class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
    @ObservedObject private var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            TextField("First Name:", text: $user.firstName)
            TextField("Last Name:", text: $user.lastName)
        }
    }
}*/

//Classes don't change (trigger a new class) when their underlying properties change, as structs do, so @State is ineffective when declared against the class.
/*class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView: View {
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            TextField("First Name:", text: $user.firstName)
            TextField("Last Name:", text: $user.lastName)
        }
    }
}*/
