//
//  Expenses.swift
//  iExpense
//
//  Created by Gavin Butler on 26-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = [] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let itemsData = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: itemsData) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
