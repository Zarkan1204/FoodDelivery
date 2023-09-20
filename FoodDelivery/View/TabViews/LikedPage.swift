//
//  LikedPage.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 20.09.2023.
//

import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete Option ..
    @State var showDeleteOption: Bool = false
    
    var body: some View {
       
        NavigationView {
           
            ScrollView(.vertical, showsIndicators: false) {
               
                VStack {
                   
                    HStack {
                        Text("Favorites")
                            .font(.custom(customFontRegular, size: 28).bold())
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image(systemName: "basket")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("LoginCircle"))
                        }
                        
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)

                    }
                    
                    // checking if liked products are empty ..
                    if sharedData.likedProducts.isEmpty {
                        
                        Group {
                           
                            Text("404")
                                .font(.custom(customFontRegular, size: 80))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("LoginCircle"))
                                .padding(.top, 50)
                            
                            Text("not found")
                                .font(.custom(customFontRegular, size: 60))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("LoginCircle"))
                            
                            Text("No favorites yet")
                                .font(.custom(customFontRegular, size: 25))
                                .fontWeight(.semibold)
                                .padding()
                            
                            Text("Hit the like button on each product page to save favorite ones.")
                                .font(.custom(customFontRegular, size: 18))
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    }
                    else {
                        
                        // Displaying Products ..
                        VStack(spacing: 15) {
                            
                            // For Designing ..
                            ForEach(sharedData.likedProducts) { product in
                                
                                HStack(spacing: 0) {
                                    
                                    if showDeleteOption {
                                        
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)

                                    }
                                    
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            Color("HomeBG")
                .ignoresSafeArea()
            )
        }
    }
   
    @ViewBuilder
    func CardView(product: Product) -> some View {
        
        HStack(spacing: 15) {
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.custom(customFontRegular, size: 18).bold())
                    .lineLimit(1)
                
                Text("Type: \(product.type.rawValue)")
                    .font(.custom(customFontRegular, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
        
            Color.white
                .cornerRadius(10)
        )
    }
    
    func deleteProduct(product: Product) {
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
          let _ = withAnimation {
                // removing ..
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
