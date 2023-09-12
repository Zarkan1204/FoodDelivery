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
}
