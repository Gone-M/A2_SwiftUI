//
//  ProductListView.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-22.
//

import SwiftUI

struct ProductListView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    var body: some View {
        ZStack {

            LinearGradient(
                gradient: Gradient(colors: [
                    colorScheme == .dark ? Color(red: 0.1, green: 0.1, blue: 0.2) : Color(red: 0.9, green: 0.95, blue: 1.0),
                    colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.3) : Color(red: 0.8, green: 0.9, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("All Products")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        print("Sort tapped")
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }

                    .padding()
                }
                .padding(.top, 10)

                HStack {
                    VStack(alignment: .leading) {
                        Text("\(products.count)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        Text("Total Products")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("💰 $\(totalValue, specifier: "%.2f")")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        Text("Total Value")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)

                if !products.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(products) { product in
                                productCard(product: product)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                } else {

                    Spacer()
                    
                    VStack {
                        Image(systemName: "tray")
                            .font(.system(size: 70))
                            .foregroundColor(.gray)
                            .padding()
                        Text("No Products Found 😕")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        Text("Add some products to see them here")
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private var totalValue: Double {
        products.reduce(0) { $0 + $1.price }
    }
    
    private func productCard(product: Product) -> some View {
        HStack(spacing: 15) {

            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "cube")
                        .foregroundColor(.blue)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name ?? "Unknown Product")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(product.desc ?? "No Description")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text(product.provider ?? "Unknown Provider")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            Spacer()

            Text("$\(product.price, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.green)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        )
    }
}

#Preview {
    ProductListView()
}
