//
//  NewProductItemView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 07/03/23.
//

import SwiftUI

struct NewProductItemView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var isShowing: Bool
    @Binding var selectedBill: Bill
    @State private var productName: String = ""
    @State private var productPrice: String = ""
    
    
    private var isButtonDisabled: Bool {
        if productName.isEmpty || productPrice.isEmpty {
            return true
        } else { return false }
    }
    
    // MARK: - FUNCTIONS
    private func addProduct () {
        withAnimation {
            let product = Product(context: managedObjectContext)
            product.id = UUID()
            product.name = productName
            product.price = Double(productPrice) ?? 0.0
            product.quantity = 1
            product.bill = selectedBill
            product.bill?.id = selectedBill.id
            product.bill?.date = selectedBill.date
            product.bill?.name = selectedBill.unwrappedName
            
            try? managedObjectContext.save()
            
            productName = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                TextField("Novo Produto", text: $productName)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        Color(UIColor.tertiarySystemBackground)
                    )
                    .cornerRadius(10)
                
                TextField("Valor do Produto", text: $productPrice)
                    .keyboardType(.decimalPad)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        Color(UIColor.tertiarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button(action: {
                    addProduct()
                    feedback.impactOccurred()
                }, label: {
                    Spacer()
                    Text("Adicionar")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled)
                .padding()
                .background(isButtonDisabled ? Color.gray : comandinhaOrange)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
               Color(UIColor.secondarySystemBackground)
            )
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        }
        .padding()
    }
}
