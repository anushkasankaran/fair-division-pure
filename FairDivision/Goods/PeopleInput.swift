//
//  PeopleInput.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/2/24.
//

import SwiftUI

struct PeopleInput: View {
    @StateObject var matrixState = GoodMatrix()
    @State private var people: [Agent] = []
    @Binding var goods: [Good]
    @State private var newPerson: String = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/9)
                    ForEach(people) { agent in
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(20)
                                .shadow(radius: 7)
                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/14)
                            Text(agent.name)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40)
                            Button(action: {
                                if let index = people.firstIndex(where: { $0.id == agent.id }) {
                                    people.remove(at: index)
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
                        TextField("Enter Name...", text: $newPerson)
                        .padding(.leading)
                        .font(.system(size: 24))
                        .onSubmit {
                            if !people.contains(where: {$0.name.lowercased() == newPerson.lowercased()}) {
                                self.addPerson()
                                newPerson = ""
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
                    NavigationLink(destination: GoodsInput(selection: .constant(3)).navigationBarBackButtonHidden(true)) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .foregroundColor(.black)
                    }
                    Text("People")
                        .font(.system(size: 40))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .offset(y: -UIScreen.main.bounds.height/2.7)
                
                ZStack {
                    if (people.count >= 2) {
                        HStack {
                            NavigationLink(destination: CreditsSelection(matrixState: matrixState, goods: $goods, people: $people).navigationBarBackButtonHidden(true)) {
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
                            .simultaneousGesture(TapGesture().onEnded {
                                matrixState.setSize(peopleCount: people.count, goodsCount: goods.count)
                            })
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
    
    private func addPerson() {
        if !newPerson.isEmpty {
            people.append(Agent(name: newPerson))
        }
        newPerson = ""
        print(people)
    }
}

#Preview {
    PeopleInput(goods: .constant([
        Good(name: "Good 1"),
        Good(name: "Good 2"),
        Good(name: "Good 3")
    ]))
}
