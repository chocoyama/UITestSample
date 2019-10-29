//
//  DetailView.swift
//  UITestSample
//
//  Created by 横山 拓也 on 2019/10/30.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let number: Int
    
    var body: some View {
        Text("\(number)")
            .font(.system(size: 40))
            .accessibility(identifier: "DetailView.Text")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(number: 0)
    }
}
