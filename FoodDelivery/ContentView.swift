//
//  ContentView.swift
//  FoodDelivery
//
//  Created by Мой Macbook on 26.07.2023.
//

import SwiftUI

struct ContentView: View {
    // Log Status..
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        Group {
            if log_Status {
                MainPage()
            }
            else  {
                OnBoardigPage()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
