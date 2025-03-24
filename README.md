# A2_iOS_FirstName_StudentID

## Overview

This iOS application was developed using **SwiftUI** and **Core Data** as part of Assignment 2.  
The app manages a collection of products, each with essential details, and provides a simple, user-friendly interface for navigating, searching, viewing, and adding products.

## Features

- ✅ Display of **Product ID**, **Name**, **Description**, **Price**, and **Provider**
- ✅ Automatically displays the **first product** on app launch
- ✅ Ability to **navigate** through all products
- ✅ **Search** functionality by product name or description
- ✅ Ability to **add a new product**
- ✅ **Full product list view** with product name and description

## Technologies Used

- **SwiftUI** – UI development
- **Core Data** – Persistent local storage for products
- **Xcode 15** – Project development and testing

## Project Structure

- ProductModel – Core Data entity with attributes:
  - productID: UUID
  - name: String
  - desc: String
  - price: Double
  - provider: String
- ContentView – Main screen with navigation and product display
- AddProductView – Allows user to input and save new products
- ProductListView – Shows list of all products (name + description)
- SearchBar – Allows user to filter/search by name or description

## How to Run

1. Clone the repo:
git clone https://github.com/Gone-M/A2_SwiftUI.git

2. Open the project in **Xcode**
3. Build and run on iOS Simulator or real device

## Requirements Met

- [x] Display product info (ID, name, description, price, provider)
- [x] Auto-display first product on launch
- [x] Navigate through products
- [x] Search functionality
- [x] Add new products
- [x] Full product list with name & description

## GitHub Commit History

✅ Project contains **20+ commits** showing continuous progress and feature implementation.

---

> ⚠️ *This project was developed for academic purposes only.*
