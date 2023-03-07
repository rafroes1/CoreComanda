//
//  DataController.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 03/03/23.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Comanda")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Cora data failed to load: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
