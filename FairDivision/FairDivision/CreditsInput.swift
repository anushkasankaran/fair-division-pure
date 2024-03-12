//
//  CreditsInput.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/8/24.
//

import SwiftUI

struct CreditsInput: View {
//    Change goods to take values from GoodsInput
    var name: String
    @State private var goods: [String] = ["Hello", "World"]
    @State var inputs: [Int] = []
    
    var body: some View {
        ZStack{
            ScrollView {
                Spacer().frame(height: UIScreen.main.bounds.height/7)
                ForEach(goods, id: \.self) { good in
                    Text(good)
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                }
                .padding(.bottom, 10)
            }
            
            ZStack {
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height/5)
                    .ignoresSafeArea()
                    .foregroundColor(Color(hex: 0xFBF8F0))
                    .blur(radius: 8)
                NavigationLink(destination: PeopleInput()) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .foregroundColor(.black)
                }
                VStack {
                    Text(name)
                        .font(.system(size: 40))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Input values for each good")
                        .foregroundColor(Color(hex: 0x707070))
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .offset(y: 12)
            }
            .offset(y: -UIScreen.main.bounds.height/2.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(hex: 0xFBF8F0).ignoresSafeArea()
        }
    }
}

#Preview {
    CreditsInput(name: "Adi")
}
