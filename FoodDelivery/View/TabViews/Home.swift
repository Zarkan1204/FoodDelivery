//
//  Home.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 03.08.2023.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    
    // Shared Data..
    @EnvironmentObject var sharedData: SharedDataModel
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                // Serch Bar..
                ZStack {
                    if homeData.searchActivated{
                        SearchBar()
                    }
                    else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }
                
                Text("Order online\ncollect in store")
                    .font(.custom(customFontRegular, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                // Product Tab..
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(ProductType.allCases, id: \.self) {type in
                            
                            // Product Type View
                            ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                // Products Page..
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        
                        ForEach(homeData.filteredProducts) { product in
                            
                            // Product Card View..
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 30)
                
                // See More Button ..
                // This button will show all products on the current product type ..
                //Since here were showing only 4 ..
                
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    // Since we need image ar right ..
                    Label {
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color("LoginCircle"))
                    } icon: {
                        Text("see more")
                            .font(.custom(customFontRegular, size: 15).bold())
                            .foregroundColor(Color("LoginCircle"))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                    .padding(.top, 10)
                }

            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        // Updating data whenever tab changes..
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
        // Preview Issue
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
        }
        // Displaying Search View..
        .overlay(
            ZStack{
                if homeData.searchActivated{
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        )
    }
    
    // Since we're adding matched geometry effect..
    //avoiding code replication..
    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            // Since we need a separate view for search bar..
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            // Add Matched Geometry effect..
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
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
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
        //Showing Product detail when tapped..
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
        Button {
            // Updating Current Type..
            withAnimation {
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFontRegular, size: 15))
                .fontWeight(.semibold)
            // Changing Color based on Current product Type..
                .foregroundColor(homeData.productType == type ? Color("myColor") : Color.gray)
                .padding(.bottom, 10)
            // Adding Indicator at bottom..
                .overlay(
                
                    // Adding Matched Geometry Effect..
                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color("myColor"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }
                        else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    
                    ,alignment: .bottom
                )
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
