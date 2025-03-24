//
//  SearchProductView.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-22.
//

import SwiftUI
import CoreData

struct SearchProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    @State private var query = ""
    @State private var results: [Product] = []
    @State private var hasSearched = false
    
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
                    
                    Text("Search")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                .padding(.top, 10)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                    TextField("Search by name or description", text: $query)
                        .padding(.vertical, 10)
                    
                    if !query.isEmpty {
                        Button(action: {
                            query = ""
                            results = []
                            hasSearched = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                    
                    Button(action: {
                        search()
                    }) {
                        Text("Search")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                    }
                    .padding(.trailing, 8)
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 10)

                VStack {

                    if hasSearched {
                        HStack {
                            Text("\(results.count) Results")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                    }
                    
                    if !hasSearched {

                        Spacer()
                        
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 70))
                                .foregroundColor(.gray)
                                .padding()
                            
                            Text("Search Products")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            
                            Text("Enter a search term and press Search")
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    } else if results.isEmpty {

                        Spacer()
                        
                        VStack {
                            Image(systemName: "magnifyingglass.circle")
                                .font(.system(size: 70))
                                .foregroundColor(.gray)
                                .padding()
                            
                            Text("No matching products")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            
                            Text("Try different search terms")
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    } else {

                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(results) { product in
                                    searchResultCard(product: product)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
        .navigationBarHidden(true)
    }
    
    private func search() {
        hasSearched = true
        if query.isEmpty {
            results = []
            return
        }
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR desc CONTAINS[c] %@ OR provider CONTAINS[c] %@", query, query, query)
        results = (try? viewContext.fetch(request)) ?? []
    }
    
    private func searchResultCard(product: Product) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(product.name ?? "Unknown Product")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
            }

            if let description = product.desc, !description.isEmpty {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            HStack {
                Image(systemName: "building.2")
                    .foregroundColor(.blue)
                    .font(.subheadline)
                
                Text(product.provider ?? "Unknown Provider")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
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
    SearchProductView()
}
