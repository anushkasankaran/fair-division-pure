//
//  GoodsInput.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/2/24.
//

import SwiftUI

struct GoodsInput: View {
//    Change to binding var to allow to be used in CreditsInput
    @State private var goods: [String] = ["Hello", "World"]
    @State private var newGood: String = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView {
                Spacer().frame(height: UIScreen.main.bounds.height/9)
                ForEach(goods, id: \.self) { good in
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20)
                            .shadow(radius: 7)
                            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/14)
                        Text(good)
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .frame(width: UIScreen.main.bounds.width - 40)
                        Button(action: {
                                if let index = goods.firstIndex(of: good) {
                                    goods.remove(at: index)
                                }
                            }) {
                                Image(systemName: "x.circle")
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width - 50, alignment: .trailing)
                            .padding(.trailing)
                    }
                }
                .padding(.bottom, 10)
                
                ZStack {
                    if isEditing {
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20)
                            .shadow(radius: 7)
                        TextField("Enter good", text: $newGood, onCommit: {
                            self.addGood()
                            self.isEditing = false
                        })
                        .padding(.leading)
                        .font(.system(size: 24))
                    } else {
                        Button(action: {
                            newGood = ""
                            self.isEditing = true
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add Item")
                            }
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/14)
            }
            .frame(maxWidth: .infinity)
            
            ZStack {
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height/6.5)
                    .ignoresSafeArea()
                    .foregroundColor(Color(hex: 0xFBF8F0))
                    .blur(radius: 8)
                NavigationLink(destination: LandingChoice()) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .foregroundColor(.black)
                }
                Text("Goods")
                    .font(.system(size: 40))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .offset(y: -UIScreen.main.bounds.height/2.5)
            
            NavigationLink(destination: PeopleInput()) {
                ZStack {
                    Rectangle()
                        .frame(width: 147, height: 54)
                        .foregroundColor(Color(hex: 0x7CB8FF))
                        .border(Color(hex: 0x669EE0))
                        .cornerRadius(20)
                    
                    Text("Done")
                        .foregroundColor(.black)
                        .font(.system(size: 24))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(hex: 0xFBF8F0).ignoresSafeArea()
        }
    }
    
    private func addGood() {
        if !newGood.isEmpty {
            goods.append(newGood)
        }
        newGood = ""
        print(goods)
    }
}

#Preview {
    GoodsInput()
}
