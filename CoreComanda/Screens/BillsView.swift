//
//  BillsView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 07/03/23.
//

import SwiftUI

struct BillsView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var bills: FetchedResults<Bill>
    
    @Binding var selectedBill: Bill
    @Binding var showingProductScreen: Bool
    
    @State private var isAnimating: Bool = false
    @State private var showNewBillItem: Bool = false
    
    // MARK: - FUNCTIONS
    func deleteBill (offsets: IndexSet) {
        for offset in offsets {
            let bill = bills[offset]
            managedObjectContext.delete(bill)
        }
        
        try? managedObjectContext.save()
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack (content: {
                LogoView()
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : -10)
                
                List {
                    ForEach(bills, id: \.id) { bill in
                        VStack (alignment: .leading, spacing: 8, content: {
                            Text("\(bill.unwrappedName)".capitalized)
                                .foregroundColor(comandinhaGold)
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("\(bill.formattedDate)".capitalized)
                                .font(.caption)
                                .fontWeight(.light)
                        })
                        .onTapGesture {
                            feedback.impactOccurred()
                            withAnimation(.easeOut){
                                showingProductScreen.toggle()
                                selectedBill = bill
                            }
                        }
                    }
                    .onDelete(perform: deleteBill)
                }
                
                Button(action: {
                    showNewBillItem = true
                    feedback.impactOccurred()
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                    Text("Nova Comanda")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                })
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .background(
                    comandinhaGold.clipShape(Capsule())
                )
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                
            })
            .onAppear(perform: {
                withAnimation(.easeOut(duration: 1)){
                    isAnimating = true
                }
            })
            .blur(radius: showNewBillItem ? 8.0 : 0, opaque: false)
            .transition(.move(edge: .bottom))
            .animation(.easeOut(duration: 0.5))
            
            if showNewBillItem {
                BlankView()
                    .onTapGesture {
                        withAnimation() {
                            showNewBillItem = false
                        }
                    }
                NewBillsItemView(isShowing: $showNewBillItem)
            }
        }
        .padding(.bottom, 8)
    }
}
