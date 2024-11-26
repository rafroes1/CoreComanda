//
//  NewBillsItemView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 07/03/23.
//

import SwiftUI

struct NewBillsItemView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var isShowing: Bool
    @State private var billName: String = ""
    
    private var isButtonDisabled: Bool {
        billName.isEmpty
    }
    
    // MARK: - FUNCTIONS
    private func addBill () {
        withAnimation {
        
            let bill = Bill(context: managedObjectContext)
            bill.id = UUID()
            bill.name = billName
            bill.date = Date.now
        
            try? managedObjectContext.save()
            
            billName = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(content: {
            Spacer()
            
            VStack(spacing: 16, content: {
                TextField("Nova Comanda", text: $billName)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        Color(UIColor.tertiarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button(action: {
                    addBill()
                    feedback.impactOccurred()
                }, label: {
                    Spacer()
                    Text("CRIAR")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled)
                .padding()
                .background(isButtonDisabled ? Color.gray : comandinhaOrange)
                .cornerRadius(10)
            })
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
               Color(UIColor.secondarySystemBackground)
            )
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        })
        .padding()
    }
}
