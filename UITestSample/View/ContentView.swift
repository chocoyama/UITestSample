//
//  ContentView.swift
//  UITestSample
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var favoriteCount: Int = 0
    @State var starCount: Int = 0
    @State var sheetPresented = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { self.favoriteCount += 1 }) {
                    Image(systemName: "heart.fill")
                }.accessibility(identifier: "ContentView.FavoriteButton")
                
                Text("\(favoriteCount)")
                    .accessibility(identifier: "ContentView.FavoriteText")
            }
            
            HStack {
                Button(action: { self.starCount += 1 }) {
                    Image(systemName: "star.fill")
                }.accessibility(identifier: "ContentView.StarButton")
                
                Text("\(starCount)")
                    .accessibility(identifier: "ContentView.StarText")
            }
            
            Button(action: { self.sheetPresented = true }) {
                Text("Show List")
            }.sheet(isPresented: $sheetPresented) {
                ListView()
                    .onDisappear { self.sheetPresented = false }
            }.accessibility(identifier: "ContentView.PresentationButton")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
