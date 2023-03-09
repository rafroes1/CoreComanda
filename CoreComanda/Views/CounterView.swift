//
//  CounterView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 07/03/23.
//

import SwiftUI

struct CounterView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var selectedProduct: Product
    
    var body: some View {
        HStack {
            Button(action: {
                selectedProduct.quantity += 1
                try? self.managedObjectContext.save()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(comandinhaGold)
                    .frame(width: 25, height: 25)
            })
            .buttonStyle(BorderlessButtonStyle())
            
            Text("\(selectedProduct.quantity)")
            
            Button(action: {
                if selectedProduct.quantity > 1 {
                    selectedProduct.quantity -= 1
                }
                try? self.managedObjectContext.save()
            }, label: {
                Image(systemName: "minus")
                    .foregroundColor(comandinhaGold)
                    .frame(width: 25, height: 25)
            })
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
