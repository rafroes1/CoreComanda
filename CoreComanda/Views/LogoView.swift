//
//  LogoView.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 07/03/23.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack (content: {
            Text("Comandinha".uppercased())
                .font(.title3)
            
            Image("beer-mug-gold")
                .resizable()
                .frame(width: 30, height: 30)
        })
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
