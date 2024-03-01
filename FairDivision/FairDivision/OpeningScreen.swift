//
//  OpeningScreen.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 2/23/24.
//

import SwiftUI

struct OpeningScreen: View {
    var body: some View {
        ZStack {
            Image("OpeningBackground")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.size.width)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Spacer()
                Image("DownwardCarat")
                    .opacity(0.3)
                Image("DownwardCarat")
                    .opacity(0.65)
                Image("DownwardCarat")
                    .padding(.bottom, 25)
            }
        }
    }
}

#Preview {
    OpeningScreen()
}
