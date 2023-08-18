//
//  MoreProductsView.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 16.08.2023.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        VStack {
            Text("More Products")
                .font(.custom(customFontRegular, size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
