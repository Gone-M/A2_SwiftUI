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
        do {
            try context.save()
        } catch {
            print("❌ Failed to save product: \(error.localizedDescription)")
        }
    }

    func fetchAllProducts() -> [Product] {
            let request: NSFetchRequest<Product> = Product.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Product.name, ascending: true)]
            
            do {
                return try context.fetch(request)
            } catch {
                print("⚠️ Failed to fetch products: \(error.localizedDescription)")
                return []
            }
        }
    }
