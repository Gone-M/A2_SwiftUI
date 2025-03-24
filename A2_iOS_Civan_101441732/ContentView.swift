//
//  ContentView.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-22.
//


import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
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
                
                VStack(spacing: 25) {
                    Image(systemName: "cart.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.blue)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 120, height: 120)
                        )
                        .padding(.top, 30)
                    
                    Text("Product Management")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    VStack(spacing: 16) {
                        menuCard(
                            destination: ProductDetailView(),
                            title: "View Products One by One",
                            subtitle: "Detailed product view",
                            icon: "list.bullet",
                            color: .blue
                        )
                        
                        menuCard(
                            destination: ProductListView(),
                            title: "View All Products",
                            subtitle: "Comprehensive list view",
                            icon: "square.grid.2x2",
                            color: .green
                        )
                        
                        menuCard(
                            destination: SearchProductView(),
                            title: "Search Product",
                            subtitle: "Filter by name",
                            icon: "magnifyingglass",
                            color: .orange
                        )
                        
                        menuCard(
                            destination: AddProductView(),
                            title: "Add New Product",
                            subtitle: "Expand product catalog",
                            icon: "plus.circle",
                            color: .red
                        )
                    }
                    .padding(.horizontal)
                    
                    Spacer()

                    Text("A2_iOS_Civan_Metin_101441732")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 10)
                }
            }
            .navigationBarHidden(true)
        }
    }

    private func menuCard<Destination: View>(
        destination: Destination,
        title: String,
        subtitle: String,
        icon: String,
        color: Color
    ) -> some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(color)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
        }
    }
}

#Preview {
    ContentView()
}
