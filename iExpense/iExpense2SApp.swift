//
//  iExpenseApp2s.swift
//  iExpense2s
//
//  Created by Paul Hudson on 15/10/2023.
//

import SwiftUI

@main
struct iExpense2sApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
