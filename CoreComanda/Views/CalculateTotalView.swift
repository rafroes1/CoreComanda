//
//  CalculateTotalView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 09/03/23.
//

import SwiftUI

struct CalculateTotalView: View {
    // MARK: - PROPERTIES
    @State private var selectedServiceTax = "Não"
    @State private var totalBillPrice = 0.0
    
    @Binding var selectedBill: Bill
    
    // MARK: - FUNCTIONS
    private func calculateTotal() {
        totalBillPrice = 0.0
        
        for product in selectedBill.productsArray {
            totalBillPrice = totalBillPrice + (Double(product.quantity) * product.price)
        }
        
        totalBillPrice = totalBillPrice * servicePercentage[selectedServiceTax]!
        selectedBill.lastTotal = totalBillPrice
    }
    
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 10) {
                
                HStack {
                    Text("Taxa de serviço")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text("Total da conta")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Picker("Taxa de serviço", selection: $selectedServiceTax){
                        ForEach(Array(servicePercentage.sorted(by: {$0.1 > $1.1 })), id: \.key) { key, value in
                            Text(key)
                        }
                    }
                    
                    Spacer()
                    
                    Text("\(String(format: "R$ %.2f", totalBillPrice))")
                }
                
                Button(action: {
                    calculateTotal()
                    feedback.impactOccurred()
                }, label: {
                    Spacer()
                    Text("Calcular")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                })
                .padding()
                .background(comandinhaOrange)
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
