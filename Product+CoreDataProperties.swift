//
//  Product+CoreDataProperties.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var provider: String?

}

extension Product : Identifiable {

}
