//
//  AddProductView.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-22.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @State private var name = ""
    @State private var desc = ""
    @State private var price = ""
    @State private var provider = ""

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
                        dismiss()
                    }) {
                        Text("Cancel")
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("Add Product")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        let newProduct = Product(context: viewContext)
                        newProduct.id = UUID()
                        newProduct.name = name
                        newProduct.desc = desc
                        newProduct.price = Double(price) ?? 0.0
                        newProduct.provider = provider
                        try? viewContext.save()
                        dismiss()
                    }) {
                        Text("Save")
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    .disabled(name.isEmpty || desc.isEmpty || provider.isEmpty || price.isEmpty)
                    .padding()
                }
                .padding(.top, 10)
                
                ScrollView {
                    VStack(spacing: 25) {
                        Image(systemName: "cube.box.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                            .padding()
                            .background(
                                Circle()
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 130, height: 130)
                            )
                            .padding(.top, 20)

                        VStack(spacing: 20) {
                            formField(
                                icon: "tag.fill",
                                title: "Product Name",
                                placeholder: "Enter product name",
                                text: $name
                            )

                            formField(
                                icon: "text.alignleft",
                                title: "Description",
                                placeholder: "Enter product description",
                                text: $desc,
                                isMultiline: true
                            )

                            formField(
                                icon: "dollarsign.circle.fill",
                                title: "Price",
                                placeholder: "Enter price",
                                text: $price,
                                keyboardType: .decimalPad
                            )

                            formField(
                                icon: "building.2.fill",
                                title: "Provider",
                                placeholder: "Enter provider name",
                                text: $provider
                            )

                            Button(action: {
                                let newProduct = Product(context: viewContext)
                                newProduct.id = UUID()
                                newProduct.name = name
                                newProduct.desc = desc
                                newProduct.price = Double(price) ?? 0.0
                                newProduct.provider = provider
                                try? viewContext.save()
                                dismiss()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title3)
                                    
                                    Text("Add Product")
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(isFormValid ? Color.blue : Color.gray)
                                )
                            }
                            .disabled(!isFormValid)
                            .padding(.top, 10)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(UIColor.systemBackground))
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private var isFormValid: Bool {
        !name.isEmpty && !desc.isEmpty && !price.isEmpty && !provider.isEmpty
    }

    private func formField(
        icon: String,
        title: String,
        placeholder: String,
        text: Binding<String>,
        isMultiline: Bool = false,
        keyboardType: UIKeyboardType = .default
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.headline)
            }
            
            if isMultiline {
                ZStack(alignment: .topLeading) {
                    if text.wrappedValue.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray.opacity(0.8))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                    }
                    
                    TextEditor(text: text)
                        .frame(minHeight: 100)
                        .padding(4)
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            } else {
                TextField(placeholder, text: text)
                    .keyboardType(keyboardType)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    AddProductView()
}
