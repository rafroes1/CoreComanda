//
//  ContentView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 03/03/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var bills: FetchedResults<Bill>
    
    @State private var showingProductsScreen = false
    @State private var selectedBill = Bill()
    
    // MARK: - FUNCTIONS
    func deleteBill (offsets: IndexSet) {
        for offset in offsets {
            let bill = bills[offset]
            managedObjectContext.delete(bill)
        }
        
        try? managedObjectContext.save()
    }
    
    var body: some View {
        if !showingProductsScreen {
            VStack {
                List {
                    ForEach(bills, id: \.id) { bill in
                        VStack {
                            Text("\(bill.name ?? "unknown") -> \(bill.id ?? UUID())")
                            Text("\(bill.date ?? Date.now)")
                        }
                        .onTapGesture {
                            showingProductsScreen.toggle()
                            selectedBill = bill
                        }
                        
                    }
                    .onDelete(perform: deleteBill)
                }
                    
                    Button(action: {
                        let name = ["coco bambu", "grand cru", "casa7", "habbibs", "milazzo"]
                        
                        let bill = Bill(context: managedObjectContext)
                        bill.id = UUID()
                        bill.name = name.randomElement()
                        bill.date = Date.now
                        
                        try? managedObjectContext.save()
                    }, label: {
                        Text("Add")
                    })
            }
            .padding()
        } else {
            ProductsView(bill: $selectedBill, showingProductScreen: $showingProductsScreen)
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
