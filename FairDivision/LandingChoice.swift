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
    @Binding var selection: Int
        
    init(selection: Binding<Int>) {
        self._selection = selection
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Welcome to FairShare!")
                        .offset(y: -30)
                        .font(.system(size: 30))
                        .padding(.horizontal)
                    Text("This experimental app is meant to help you divide goods and tasks among participants in a fair manner.")
                        .padding(.bottom)
                        .padding(.horizontal)
                    Text("Alternatively, to divide negative items (e.g. rent, work details, chores), select Tasks!")
                        .padding(.bottom)
                        .padding(.horizontal)
                    Text("To divide positive items (e.g. inheritance, food, prizes), select Goods!")
                        .padding(.bottom, 25)
                        .padding(.horizontal)
                    ZStack {
    //                    Image("ChoiceCard")
    //                        .offset(x: 4)
                        VStack {
                            Button(action: {
                                selection = 3
                            }) {
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
                            Button(action: {
                                selection = 1
                            }) {
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
    }
}

#Preview {
    LandingChoice(selection: .constant(2))
}
