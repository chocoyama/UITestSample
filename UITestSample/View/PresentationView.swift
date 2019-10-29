//
//  PresentationView.swift
//  UITestSample
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct PresentationView: View {
    var body: some View {
        Text("PresentationView")
            .accessibility(identifier: .presentationViewLabel)
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView()
    }
}
