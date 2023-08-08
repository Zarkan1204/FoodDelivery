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
    
        Product(type: .Sushi, title: "Philadelphia", prise: "500", productImage: "fila")
        
    ]
}
