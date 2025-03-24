//
//  ProductViewModel.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-22.
//

import Foundation
import CoreData

class ProductViewModel: ObservableObject {
    let context = PersistenceController.shared.container.viewContext

    func addProduct(name: String, desc: String, price: Double, provider: String) {
        let newProduct = Product(context: context)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.desc = desc
        newProduct.price = price
        newProduct.provider = provider
        try? context.save()
    }

    func fetchAllProducts() -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
}
