//
//  ContentView.swift
//  iExpense2S
//
//  Created by Paul Hudson on 15/10/2023.
//

import SwiftData
import SwiftUI

@Model
class ExpenseItem {
    let name: String
    let type: String
    let amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

struct ContentView: View {
    @State private var showingAddExpense = false
    @State private var expenseType = "All"
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount, order: .reverse)
    ]

    var body: some View {
        NavigationStack {
            ExpensesList(type: expenseType, sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                    
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle"){
                        Picker("Filter", selection: $expenseType) {
                            Text("Show all expenses")
                                .tag("All")
                            
                            Divider()
                            
                            ForEach(AddView.types, id: \.self) { type in
                                Text(type)
                                    .tag(type)
                            }
                        }
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort by", selection: $sortOrder) {
                            Text("Name A to Z")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            
                            Text("Name Z to A")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name, order: .reverse),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            
                            Text("Amount, Low to High")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                            Text("Amount, High to Low")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView()
                }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
