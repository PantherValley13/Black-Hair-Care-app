//
//  ProductDetailView.swift
//  Black Hair Care app
//
//  Created by Darius Church on 2/28/25.
//

import SwiftUI

struct ProductDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Product Image
                Image("image-3") // Replace with your image asset
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()
                
                // Product Name
                Text("Shea Moisture Shampoo")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.horizontal, 16)
                
                // Product Price
                Text("$12.99")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                
                // Product Description
                Text("A nourishing shampoo designed for natural hair. Infused with shea butter, coconut oil, and peppermint to cleanse and moisturize.")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                
                // Product Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("4.8 (1.2k reviews)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                
                // Add to Cart Button
                Button(action: {
                    print("Added to cart")
                }) {
                    Text("Add to Cart")
                        .font(.system(size: 18, weight: .medium))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 16)
                
                // Buy Now Button
                Button(action: {
                    print("Buy now")
                }) {
                    Text("Buy Now")
                        .font(.system(size: 18, weight: .medium))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 16)
        }
        .navigationTitle("Product Details")
    }
}

// MARK: - Preview
#Preview {
    ProductDetailView()
}
