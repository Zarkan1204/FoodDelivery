//
//  MainPage.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 03.08.2023.
//

import SwiftUI

struct MainPage: View {
    // Current tab..
    @State var currentTab: Tab = .Home
    
    //Hiding TabBar..
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        VStack(spacing: 0) {
            // Tab View..
            TabView(selection: $currentTab) {
                Home()
                    .tag(Tab.Home)
                Text("Liked")
                    .tag(Tab.Liked)
                Text("Profile")
                    .tag(Tab.Profile)
                Text("Cart")
                    .tag(Tab.Cart)
            }
            //Custom TabBar..
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) {tab in
                    
                    Button {
                        // updating tab..
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        // Applying little shadow at bg..
                            .background(
                            
                            Color("myColor2")
                                .opacity(0.1)
                                .cornerRadius(5)
                            // Blurring..
                                .blur(radius: 5)
                            // Making little big ..
                                .padding(-7)
                                .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("myColor2") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

//Making Case Iteratable..
//Tab Case..
enum Tab: String, CaseIterable {
    
    //Raw value must be image name in asset..
    case Home = "house"
    case Liked = "heart"
    case Profile = "person"
    case Cart = "cart"
}
