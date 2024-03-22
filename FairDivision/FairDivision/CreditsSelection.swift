//
//  CreditsSelection.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/8/24.
//

import SwiftUI

struct CreditsSelection: View {
//    Temporary values to create UI -> will be binding var taken from inputted values from people input page
//    @State private var people: [Agent] = [
//        Agent(name: "Hello"), Agent(name: "World")
//    ]
//    @State private var goods: [Good] = [
//        Good(name: "Hello"), Good(name: "World")
//    ]
    @State private var people: [String] = ["Hello", "World"]
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/7)
                    ForEach(people, id: \.self) { person in
                        NavigationLink (destination: CreditsInput(agent: Agent()).navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Rectangle()
                                    .fill(.white)
                                    .cornerRadius(20)
                                    .shadow(radius: 7)
                                    .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/14)
                                Text("Placeholder")
                                    .font(.system(size: 24))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                    .frame(width: UIScreen.main.bounds.width - 40)
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.black)
                                    .frame(maxWidth: UIScreen.main.bounds.width - 50, alignment: .trailing)
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
                
                ZStack {
                    Rectangle()
                        .frame(height: UIScreen.main.bounds.height/5)
                        .ignoresSafeArea()
                        .foregroundColor(Color(hex: 0xFBF8F0))
                        .blur(radius: 8)
                    NavigationLink(destination: PeopleInput().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .foregroundColor(.black)
                    }
                    VStack {
                        Text("Credits")
                            .font(.system(size: 40))
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("Input credits for each person")
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
}

#Preview {
    CreditsSelection()
}
