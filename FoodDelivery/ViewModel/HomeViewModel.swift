//
//  HomeViewModel.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 08.08.2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
   
    @Published var productType: ProductType = .Sushi
    
    @Published var products: [Product] = [
    
        Product(type: .Sushi, title: "Philadelphia", prise: "$15", productImage: "fila"),
        Product(type: .Sushi, title: "California", prise: "$10", productImage: "california"),
        Product(type: .Sushi, title: "Kaecy maki", prise: "$12", productImage: "kaecy"),
        Product(type: .Sushi, title: "Ugor roll", prise: "$10", productImage: "ugor")
        
    ]
    
    // Filter Products ..
    @Published var filteredProducts: [Product] = []
    
    // More products on the type ..
    @Published var showMoreProductsOnType: Bool = false
    
    init() {
        filterProductByType()
    }
    
    func filterProductByType() {
        
        // Filtering Product By Product Type..
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                // Since it will require more memory so were using lazy to perform more ..
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            // Limiting result ..
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
