//
//  ProductDetailView.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-22.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    @State private var currentIndex = 0
    @State private var showingAddView = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.25) : Color(red: 0.85, green: 0.95, blue: 1.0),
                    colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.35) : Color(red: 0.75, green: 0.88, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
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
                    
                    Text("Products")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: { showingAddView = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                .padding(.top, 10)
                
                if !products.isEmpty && products.indices.contains(currentIndex) {
                    let product = products[currentIndex]

                    VStack(spacing: 25) {
   
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "cube.box")
                                    .font(.system(size: 60))
                                    .foregroundColor(.blue)
                            )
                            .padding(.top, 20)

                        Text(product.name ?? "Unknown Product")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        VStack(spacing: 20) {
                            detailRow(title: "ID", value: product.id?.uuidString ?? "Unknown")
                            
                            Divider()
                            
                            detailRow(title: "Description", value: product.desc ?? "No description available")
                            
                            Divider()
                            
                            detailRow(title: "Price", value: "$\(String(format: "%.2f", product.price))")
                            
                            Divider()
                            
                            detailRow(title: "Provider", value: product.provider ?? "Unknown provider")
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(UIColor.systemBackground))
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                        
                        Spacer()

                        VStack(spacing: 12) {
                            NavigationLink(destination: ProductListView()) {
                                HStack {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Circle().fill(Color.green))
                                    
                                    Text("View All Products")
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(UIColor.secondarySystemBackground))
                                )
                            }
                            
                            NavigationLink(destination: SearchProductView()) {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Circle().fill(Color.orange))
                                    
                                    Text("Search Product")
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(UIColor.secondarySystemBackground))
                                )
                            }
                        }
                        .padding(.horizontal)

                        HStack(spacing: 30) {
                            Button(action: {
                                withAnimation {
                                    currentIndex = (currentIndex - 1 + products.count) % products.count
                                }
                            }) {
                                Image(systemName: "arrow.left.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.blue)
                            }
                            
                            Text("\(currentIndex + 1) of \(products.count)")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                withAnimation {
                                    currentIndex = (currentIndex + 1) % products.count
                                }
                            }) {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 15)
                    }
                } else {
                    VStack {
                        Spacer()
                        
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 70))
                            .foregroundColor(.orange)
                            .padding()
                        
                        Text("No Products Found")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        Text("Please add some products first")
                            .foregroundColor(.secondary)
                        
                        Button(action: { showingAddView = true }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title3)
                                
                                Text("Add Product")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                            .padding(.top, 20)
                        }
                        
                        Spacer()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showingAddView) {
            AddProductView()
        }
    }
    
    private func detailRow(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    ProductDetailView()
}
