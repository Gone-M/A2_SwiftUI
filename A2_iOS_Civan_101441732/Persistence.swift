//
//  Persistence.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Civan_Metin_101441732")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        preloadData()
    }

    func preloadData() {
        let context = container.viewContext
        let request = NSFetchRequest<Product>(entityName: "Product")
        request.fetchLimit = 1
        if (try? context.count(for: request)) == 0 {
            for i in 1...10 {
                let product = Product(context: context)
                product.id = UUID()
                product.name = "Product \(i)"
                product.desc = "Sample Description \(i)"
                product.price = Double(i * 10)
                product.provider = "Provider \(i)"
            }
            try? context.save()
        }
    }
}
