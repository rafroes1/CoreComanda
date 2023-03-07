//
//  ProductsView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 03/03/23.
//

import SwiftUI

struct ProductsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var bill: Bill
    @Binding var showingProductScreen: Bool
    
    @State private var refresher = UUID()
    
    
    func deleteProduct (offsets: IndexSet) {
        for offset in offsets {
            let product = bill.productsArray[offset]
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
        product.bill?.id = bill.id
        product.bill?.name = bill.name
        product.bill?.date = bill.date

        try? managedObjectContext.save()
        forceRefresh()
    }
    
    var body: some View {
        VStack(spacing: 8) {
            
            List {
                ForEach(bill.productsArray, id: \.id) { product in
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
