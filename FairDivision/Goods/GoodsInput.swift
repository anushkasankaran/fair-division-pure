//
//  GoodsInput.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/2/24.
//

import SwiftUI

struct GoodsInput: View {
    @Binding var selection: Int
    
    @State private var goods: [Good] = []
    @State private var newGood: String = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/9)
                    ForEach(goods) { good in
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(20)
                                .shadow(radius: 7)
                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/14)
                            Text(good.name)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40)
                            Button(action: {
                                if let index = goods.firstIndex(where: { $0.id == good.id }) {
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
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20)
                            .shadow(radius: 7)
                        TextField("Enter Good...", text: $newGood)
                        .padding(.leading)
                        .font(.system(size: 24))
                        .onSubmit {
                            if !goods.contains(where: {$0.name.lowercased() == newGood.lowercased()}) {
                                self.addGood()
                                newGood = ""
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
                    Button(action: {
                        selection = 2
                    }) {
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
                .offset(y: -UIScreen.main.bounds.height/2.7)
                
                ZStack {
                    if (goods.count >= 2) {
                        NavigationLink(destination: PeopleInput(goods: $goods).navigationBarBackButtonHidden(true)) {
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
                    } else {
                        Rectangle()
                            .frame(width: 147, height: 54)
                            .foregroundColor(Color(hex: 0xBED5F0))
                            .cornerRadius(20)
                        
                        Text("Done")
                            .foregroundColor(.gray)
                            .font(.system(size: 24))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing)
                .padding(.bottom, 25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color(hex: 0xFBF8F0).ignoresSafeArea()
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
    private func addGood() {
        if !newGood.isEmpty {
            let newGoodItem = Good(name: newGood)
            goods.append(newGoodItem)
        }
        newGood = ""
        print(goods)
    }
}

#Preview {
    GoodsInput(selection: .constant(3))
}
