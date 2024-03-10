//
//  LandingChoice.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 2/24/24.
//

import SwiftUI

// Allow use of hex colors
extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

struct LandingChoice: View {
    var body: some View {
        VStack {
            Text("Fair Division")
                .offset(y: -15)
                .font(.system(size: 40))
                .padding(.bottom, UIScreen.main.bounds.height/20)
            ZStack {
                Image("ChoiceCard")
                    .offset(x: 4)
                VStack {
                    NavigationLink(destination: GoodsInput()) {
                        ZStack {
                            Rectangle()
                                .fill(Color(hex: 0x7CB8FF))
                                .frame(width: 255, height: 150)
                                .cornerRadius(20)
                            .shadow(color: .gray, radius: 3, x: 0, y: 3)
                            Text("GOODS")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                        }
                    }
                    .padding(.bottom, 35)
                    .padding(.top, 50)
                    NavigationLink(destination: GoodsInput()) {
                        ZStack {
                            Rectangle()
                                .fill(Color(hex: 0x7CB8FF))
                                .frame(width: 255, height: 150)
                                .cornerRadius(20)
                            .shadow(color: .gray, radius: 3, x: 0, y: 3)
                            Text("TASKS")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(hex: 0xFBF8F0).ignoresSafeArea()
        }
    }
}

#Preview {
    LandingChoice()
}
