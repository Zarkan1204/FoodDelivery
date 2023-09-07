//
//  ProductDetailView.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 07.09.2023.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    
    // For Matched Geometry effect ..
    var animation: Namespace.ID
    
    // Shared Data Model..
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        VStack {
            
            // Title Bar and Product Image..
            VStack {
                // Title Bar ..
                HStack {
                    Button {
                        // Closing View
                        withAnimation(.easeInOut) {
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        //
                    } label: {
                        Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                }
                .padding()
                
                // Product Image ..
                // Add Matched Geometry effect ..
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            // Product Details..
            ScrollView(.vertical,showsIndicators: false) {
                
                // Product Data..
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.title)
                        .font(.custom(customFontBold, size: 25).bold())
                    
                    Text("Take advantage of the promotion! When ordering two dishes, the third one is free.")
                        .font(.custom(customFontRegular, size: 20))
                        .foregroundColor(.gray)
                    
                    Button {
                        //
                    } label: {
                        Label {
                            // Since we need image at right..
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Сomposition of the dish")
                        }
                        .font(.custom(customFontRegular, size: 20).bold())
                        .foregroundColor(Color("LoginCircle"))
                    }

                    HStack {
                        Text("Total")
                            .font(.custom(customFontRegular, size: 25))
                        
                        Spacer()
                        
                        Text("\(product.prise)")
                            .font(.custom(customFontRegular, size: 35).bold())
                            .foregroundColor(Color("LoginCircle"))
                    }
                    .padding(.vertical, 20)
                    
                    Button {
                        //
                    } label: {
                        Text("add to basket")
                            .font(.custom(customFontRegular, size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("LoginCircle").cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }

                }
                .padding([.horizontal, .bottom], 25)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBG"))
            .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
            .ignoresSafeArea()
            .zIndex(0)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample Product for Building Preview..
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        MainPage()
    }
}
