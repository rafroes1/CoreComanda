//
//  Products+CoreDataProperties.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 06/03/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var price: Double
    @NSManaged public var bill: Bill?
    
    public var unwrappedId: UUID {
        id ?? UUID()
    }
    
    public var unwrappedName: String {
        name ?? "Unknown product name"
    }

}

extension Product : Identifiable {

}
