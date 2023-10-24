//
//  SharedDataModel.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 07.09.2023.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    // Detail Product Data ..
    
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    // matched Geometry effect from search page ..
    @Published var fromSearchPage: Bool = false
    
    //Liked products ..
    @Published var likedProducts: [Product] = []
    
    //Basket products ..
    @Published var cartProducts: [Product] = []
    
    //calculating total price ...
    
    func getTotalPrice() -> String {
        
        var total: Int = 0
        
        cartProducts.forEach { product in
            
            let price = product.prise.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        return "$\(total)"
    }
}
