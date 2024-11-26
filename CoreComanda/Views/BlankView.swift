//
//  BlankView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 07/03/23.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(comandinhaBlack)
        .opacity(0.3)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}
