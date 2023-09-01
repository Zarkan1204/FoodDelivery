//
//  HomeViewModel.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 08.08.2023.
//

import SwiftUI
import Combine
// Using Combine to monitor search field anf if  user leaves for 0.5 secs then starts searching..
// to avoid memory issue ..


class HomeViewModel: ObservableObject {
   
    @Published var productType: ProductType = .Sushi
    
    @Published var products: [Product] = [
    
        Product(type: .Sushi, title: "Philadelphia", prise: "$15", productImage: "fila"),
        Product(type: .Sushi, title: "California", prise: "$10", productImage: "california"),
        Product(type: .Sushi, title: "Kaecy maki", prise: "$12", productImage: "kaecy"),
        Product(type: .Sushi, title: "Ugor roll", prise: "$10", productImage: "ugor"),
        Product(type: .Sushi, title: "qqqq", prise: "$10", productImage: "sushi1"),
        Product(type: .Sushi, title: "sdcsdcsd", prise: "$12", productImage: "sushi3"),
       
        Product(type: .Pizza, title: "sdcsdcsd", prise: "$10", productImage: "pepperoni"),
        Product(type: .Pizza, title: "sdcsdcsd", prise: "$13", productImage: "italy"),
        Product(type: .Pizza, title: "sdcsdcsd", prise: "$10", productImage: "gribs"),
        Product(type: .Pizza, title: "sdcsdcsd", prise: "$15", productImage: "assorty"),
        Product(type: .Pizza, title: "sdcsdcsd", prise: "$12", productImage: "4cheese"),
        Product(type: .Pizza, title: "sdcsdcsd", prise: "$10", productImage: "margarita"),
        
        Product(type: .Burgers, title: "sdcsdcsd", prise: "$10", productImage: "chickenburger"),
        Product(type: .Burgers, title: "sdcsdcsd", prise: "$7", productImage: "gamburger"),
        Product(type: .Burgers, title: "sdcsdcsd", prise: "$8", productImage: "сheeseburger"),
        Product(type: .Burgers, title: "sdcsdcsd", prise: "$12", productImage: "bigmak"),
        Product(type: .Burgers, title: "sdcsdcsd", prise: "$8", productImage: "fishburger"),
        Product(type: .Burgers, title: "sdcsdcsd", prise: "$10", productImage: "royalburger"),
        
        Product(type: .Snacks, title: "Cheese Sticks", prise: "$10", productImage: "cheeseSticks"),
        Product(type: .Snacks, title: "Chicken Legs", prise: "$7", productImage: "chickenLegs"),
        Product(type: .Snacks, title: "Chicken Strips", prise: "$8", productImage: "chickenStrips"),
        Product(type: .Snacks, title: "French Fries", prise: "$5", productImage: "frenchFries"),
        Product(type: .Snacks, title: "Potatoes With Bacon", prise: "$10", productImage: "potatoesWithBacon"),
        Product(type: .Snacks, title: "Onion Rings", prise: "$5", productImage: "onionRings")
    ]
    
    // Filter Products ..
    @Published var filteredProducts: [Product] = []
    
    // More products on the type ..
    @Published var showMoreProductsOnType: Bool = false
    
    // Search Data..
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init() {
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                }
                else {
                    self.searchedProducts = nil
                }
            })
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
                .prefix(6)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch() {
        
        // Filtering Product By Product Type..
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                // Since it will require more memory so were using lazy to perform more ..
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
    
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
