//
//  ContentView.swift
//  UITestSample
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State var sheetPresented = false
    
    var body: some View {
        VStack {
            Text(text)
                .accessibility(identifier: "ContentView.Text")
            
            Button(action: {
                self.text = "Tapped1"
            }) {
                Text("Button1")
            }
            .accessibility(identifier: "ContentView.Button1")
            
            Button(action: {
                self.text = "Tapped2"
            }) {
                Text("Button2")
            }
            .accessibility(identifier: "ContentView.Button2")
            
            Button(action: {
                self.text = "Sheet"
                self.sheetPresented = true
            }) {
                Text("Sheet")
            }
            .sheet(isPresented: $sheetPresented) {
                PresentationView().onDisappear {
                    self.sheetPresented = false
                }
            }
            .accessibility(identifier: "ContentView.PresentationButton")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
