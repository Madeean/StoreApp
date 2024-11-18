//
//  ProductCellView.swift
//  StoreApp
//
//  Created by made reihan on 18/11/24.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product
    
    var body: some View {
        HStack (alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text(product.title).bold()
                Text(product.description)
            }
            Spacer()
            Text(product.price, format: .currency(code: Locale.currencyCode))
                .padding(5)
                .background{
                    Color.green
                }
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        }
    }
}

#Preview {
    ProductCellView(product: Product(id: 1, title: "Hellow world", price: 10000, description: "Hellow world Hellow world Hellow world Hellow world Hellow world ", images: [], category: Category(id: 1, name: "Category Hellow", image: ""), creationAt: "", updatedAt: ""))
}
