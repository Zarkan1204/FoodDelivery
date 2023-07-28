//
//  OnBoardig.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 27.07.2023.
//

import SwiftUI
let customFontBold = "Roboto-Bold"
let customFontRegular = "Roboto-Medium"

struct OnBoardig: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Find your\nFood")
                .font(.custom(customFontRegular, size: 55))
                .foregroundColor(.white)
                .fontWeight(.bold)

//            Image("onBoarding")
//                .resizable()
//                .aspectRatio(contentMode: .fit)

            Button {
                //
            } label: {
                Text("Get started")
                    .font(.custom(customFontRegular, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("myColor"))
            }
            .padding(.horizontal, 30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(

                Color("myColor")
            )
        }
    }

struct OnBoardig_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardig()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}



