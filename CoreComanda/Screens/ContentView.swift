//
//  ContentView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 03/03/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var showingProductsScreen = false
    @State private var selectedBill = Bill()
    
    // MARK: - BODY
    var body: some View {
        if !showingProductsScreen {
            BillsView(selectedBill: $selectedBill, showingProductScreen: $showingProductsScreen)
        } else {
            ProductsView(selectedBill: $selectedBill, showingProductScreen: $showingProductsScreen)
        }
    }
}
