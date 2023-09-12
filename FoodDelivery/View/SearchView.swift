//
//  SearchView.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 24.08.2023.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    
    // Shared Data ..
    @EnvironmentObject var sharedData: SharedDataModel
   
    @EnvironmentObject var homeData: HomeViewModel
    
    // Activating Text Field with the help of FocusState..
    @FocusState var startTF: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Search Bar..
            HStack(spacing: 20){
                // Close Button..
                Button {
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    // Resetting ..
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                // Search Bar..
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    // Since we need a separate view for search bar..
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    
                    Capsule()
                        .strokeBorder(Color("LoginCircle"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            
            // Showing Progress if searching..
            // else showing no results found if empty..
            if let products = homeData.searchedProducts {
                
                if products.isEmpty {
                    
                    // No Results Found ..
                    VStack(spacing: 10) {
                        Text("Item Not Found")
                            .font(.custom(customFontRegular, size: 22).bold())
                        
                        Text("Try a more generic search term ot try looking for alternative products.")
                            .font(.custom(customFontRegular, size: 16).bold())
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding()
                }
                else {
                    // Filter Results..
                    ScrollView(.vertical,showsIndicators: false) {
                        
                        VStack(spacing: 0) {
                            // Found Text..
                            Text("Found \(products.count) results")
                                .font(.custom(customFontRegular, size: 24).bold())
                                .padding(.vertical)
                            
                            // Staggered grid
                            StaggeredGrid(columns: 2, spacing: 2, list: products) { product in
                                
                                // Card View..
                                ProductCardView(product: product)
                            }
                        }
                        .padding(-2)
                    }
                }
            }
            else  {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
        
            Color("HomeBG")
            .ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            ZStack {
                
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
        
            Text(product.title)
                .font(.custom(customFontRegular, size: 18))
                .fontWeight(.semibold)
                .padding(.top, 5)
            
            Text(product.prise)
                .font(.custom(customFontRegular, size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("LoginCircle"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
        
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 15)
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
