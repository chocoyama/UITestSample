//
//  PresentationView.swift
//  UITestSample
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView {
            List((0..<100)) { (number: Int) in
                NavigationLink(destination: DetailView(number: number)) {
                    Text("\(number)")
                }
            }
            .navigationBarTitle("List")
            .accessibility(identifier: "ListView.List")
        }
    }
}

struct Listiew_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
