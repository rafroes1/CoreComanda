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
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(comandinhaOrange)
                                .frame(width: 20, height: 20)
                                .padding(.leading, 20)
                            
                            Text("Voltar")
                                .foregroundColor(comandinhaOrange)
                                .font(.headline)
                        }
                    })
                    
                    Spacer()
                    
                    Text(selectedBill.unwrappedName.capitalized)
                        .font(.title)
                        .fontWeight(.semibold)
                        .offset(x: -20)
                    
                   Spacer()
                    
                    Button(action: {
                        showNewProductItem = true
                        feedback.impactOccurred()
                    }, label: {
                        Image(systemName: "plus.app")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(comandinhaOrange)
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 20)
                    })
                }
                
                if !selectedBill.productsArray.isEmpty {
                    List {
                        ForEach(selectedBill.productsArray, id: \.id) { product in
                            HStack (spacing: 16){
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(product.unwrappedName)
                                        .foregroundColor(comandinhaOrange)
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
            .animation(.easeOut(duration: 0.5), value: showNewProductItem)
            
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
