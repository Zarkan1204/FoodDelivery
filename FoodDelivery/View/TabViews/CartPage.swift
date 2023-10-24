//
//  CartPage.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 27.09.2023.
//

import SwiftUI

// Since both of the views are mostly identical ..
struct CartPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete Option ..
    @State var showDeleteOption: Bool = false
    
    var body: some View {
       
        NavigationView {
           
            VStack(spacing: 10) {
                
                ScrollView(.vertical, showsIndicators: false) {
                   
                    VStack {
                       
                        HStack {
                            Text("Basket")
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
                            
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)

                        }
                        
                        // checking if liked products are empty ..
                        if sharedData.cartProducts.isEmpty {
                            
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
                                
                                Text("No Items added")
                                    .font(.custom(customFontRegular, size: 25))
                                    .fontWeight(.semibold)
                                    .padding()
                                
                                Text("Hit the plus button to save into basket.")
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
                                ForEach($sharedData.cartProducts) { $product in
                                    
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
                                        
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
                // Showing total and check out button ..
                if !sharedData.cartProducts.isEmpty {
                    Group {
                        HStack {
                            Text("Total")
                                .font(.custom(customFontRegular, size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFontRegular, size: 18).bold())
                                .foregroundColor(Color("LoginCircle"))
                        }
                        
                        Button {
                            //
                        } label: {
                            Text("Checkout")
                                .font(.custom(customFontRegular, size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color("LoginCircle"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal, 25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            Color("HomeBG")
                .ignoresSafeArea()
            )
        }
    }
    
    func deleteProduct(product: Product) {
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
          let _ = withAnimation {
                // removing ..
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

struct CardView: View {
    
    @Binding var product: Product
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.custom(customFontRegular, size: 18).bold())
                    .lineLimit(1)
                
                //Quantity Buttons..
                HStack(spacing: 10) {
                    Text("Quantity")
                        .font(.custom(customFontRegular, size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("LoginCircle"))
                    }
                    
                    Text("\(product.quantity)")
                        .font(.custom(customFontRegular, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("LoginCircle"))
                    }
                    
                }
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
}
