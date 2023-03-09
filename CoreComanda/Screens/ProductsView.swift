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
    
    @State private var isAnimating: Bool = false
    @State private var showNewProductItem: Bool = false
    
    // MARK: - FUNCTIONS
    private func deleteProduct (offsets: IndexSet) {
        for offset in offsets {
            let product = selectedBill.productsArray[offset]
            managedObjectContext.delete(product)
        }
        
        try? managedObjectContext.save()
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        showingProductScreen = false
                        feedback.impactOccurred()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(comandinhaGold)
                                .frame(width: 30, height: 30)
                            
                            Text("Voltar")
                                .foregroundColor(comandinhaGold)
                                .offset(x: -12)
                        }
                    })
                    
                    Spacer()
                    
                    Text(selectedBill.unwrappedName.capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        showNewProductItem = true
                        feedback.impactOccurred()
                    }, label: {
                        Image(systemName: "plus.app")
                            .foregroundColor(comandinhaGold)
                            .frame(width: 38, height: 38)
                    })
                }
                
                if !selectedBill.productsArray.isEmpty {
                    List {
                        ForEach(selectedBill.productsArray, id: \.id) { product in
                            HStack (spacing: 16){
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(product.unwrappedName)
                                        .foregroundColor(comandinhaGold)
                                        .font(.headline)
                                    Text("Preço un.: \(String(format: "R$ %.2f", product.price))")
                                        .font(.footnote)
                                }
                                
                                Spacer()
                                
                                CounterView(selectedProduct: product)
                            }
                        }
                        .onDelete(perform: deleteProduct)
                    }
                    
                    CalculateTotalView(selectedBill: $selectedBill)
                    
                } else {
                    Spacer()
                    Text("Nenhum produto listado")
                        .font(.title3)
                        .fontWeight(.ultraLight)
                        .multilineTextAlignment(.center)
                        .opacity(0.8)
                    Spacer()
                }
            }
            .onAppear(perform: {
                withAnimation(.easeOut(duration: 1)){
                    isAnimating = true
                }
            })
            .blur(radius: showNewProductItem ? 8.0 : 0, opaque: false)
            .transition(.move(edge: .bottom))
            .animation(.easeOut(duration: 0.5))
            
            if showNewProductItem {
                BlankView()
                    .onTapGesture {
                        withAnimation() {
                            showNewProductItem = false
                        }
                    }
                NewProductItemView(isShowing: $showNewProductItem, selectedBill: $selectedBill)
            }
        }
        .padding(.bottom, 8)
    }
}
