//
//  CoreComandaApp.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 03/03/23.
//

import SwiftUI

@main
struct CoreComandaApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
