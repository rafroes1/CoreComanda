//
//  Bill+CoreDataProperties.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 06/03/23.
//
//

import Foundation
import CoreData


extension Bill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bill> {
        return NSFetchRequest<Bill>(entityName: "Bill")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var products: NSSet?
    @NSManaged public var lastTotal: Double

    public var unwrappedID: UUID {
        id ?? UUID()
    }
    
    public var unwrappedName: String {
        name ?? "Unknown Bill Name"
    }
    
    public var unwrappedDate: Date {
        date ?? Date.now
    }
    
    public var unwrappedTotal : Double {
        lastTotal
    }
    
    public var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.timeZone = TimeZone(identifier: "GMT-3")
        formatter.dateFormat = "EEEE, MMM d, yyyy, HH:mm"
        return formatter.string(from: unwrappedDate)
    }
    
    public var productsArray: [Product] {
        let set = products as? Set<Product> ?? []
        
        return set.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
    
}

// MARK: Generated accessors for has
extension Bill {

    @objc(addHasObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeHasObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addHas:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Bill : Identifiable {

}
