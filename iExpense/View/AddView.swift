//
//  AddView.swift
//  iExpense
//
//  Created by Gavin Butler on 26-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type: ExpenseItemType = .personal
    @State private var amount = ""
    
    @State var expenseTypes: [ExpenseItemType] = [.personal, .business]
    @State private var expenseTypeIndex = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name:", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(self.expenseTypes, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                TextField("Amount:", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    guard let actualAmount = Int(self.amount) else { return }
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()  //Causes an inability to re-show the view
                }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
