//
//  ProductsView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 03/03/23.
//

import SwiftUI

struct ProductsView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var selectedBill: Bill
    @Binding var showingProductScreen: Bool
    
    @State private var refresher = UUID()
    
    // MARK: - FUNCTIONS
    func deleteProduct (offsets: IndexSet) {
        for offset in offsets {
            let product = selectedBill.productsArray[offset]
            managedObjectContext.delete(product)
        }
        
        try? managedObjectContext.save()
    }
    
    func forceRefresh() {
        refresher = UUID()
    }
    
    func test (){
        let product = Product(context: managedObjectContext)
        product.name = ["product1", "product2", "product3", "product4"].randomElement()
        product.id = UUID()
        product.price = Double.random(in: 0.5...10)
        product.quantity = Int32.random(in: 0...10)
        product.bill = Bill(context: managedObjectContext)
        product.bill?.id = selectedBill.id
        product.bill?.name = selectedBill.name
        product.bill?.date = selectedBill.date

        try? managedObjectContext.save()
        forceRefresh()
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 8) {
            
            List {
                ForEach(selectedBill.productsArray, id: \.id) { product in
                    VStack {
                        Text("id -> \(product.unwrappedId)")
                        HStack (spacing: 8, content: {
                            Text(product.unwrappedName)
                            Text("\(product.price)")
                            Text("\(product.quantity)")
                        })
                    }
                }
                .onDelete(perform: deleteProduct)
            }
            
            HStack{
                Button("Add", action: {
                    test()
                })
                
                Spacer()
                
                
                Button("Done", action: {
                    showingProductScreen.toggle()
                })
            }
            .padding(.horizontal, 15)
        }
    }
}
