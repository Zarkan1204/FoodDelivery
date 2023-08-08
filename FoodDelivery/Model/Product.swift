//
//  Product.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 08.08.2023.
//

import SwiftUI

// Product Model..
struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var description: String = ""
    var prise: String
    var productImage: String
    var quantity: Int = 1
}


// ProductTypes..
enum ProductType: String, CaseIterable {
    case Sushi = "Sushi"
    case Pizza = "Pizza"
    case Burgers = "Burgers"
    case Pasta = "Pasta"
}
