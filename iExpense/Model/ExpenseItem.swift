//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Gavin Butler on 26-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: ExpenseItemType
    let amount: Int
}

enum ExpenseItemType: String, Codable {
    case personal = "Personal"
    case business = "Business"
}
