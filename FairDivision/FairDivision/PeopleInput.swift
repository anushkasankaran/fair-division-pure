//
//  PeopleInput.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/2/24.
//

import SwiftUI

struct PeopleInput: View {
//    Change people to binding var to allow credit selection page to use
    @State private var people: [String] = ["Hello", "World"]
    @State private var newPerson: String = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView {
                Spacer().frame(height: UIScreen.main.bounds.height/9)
                ForEach(people, id: \.self) { person in
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20)
                            .shadow(radius: 7)
                            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/14)
                        Text(person)
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .frame(width: UIScreen.main.bounds.width - 40)
                        Button(action: {
                                if let index = people.firstIndex(of: person) {
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
                    if isEditing {
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20)
                            .shadow(radius: 7)
                        TextField("Enter Name", text: $newPerson, onCommit: {
                            self.addPerson()
                            self.isEditing = false
                        })
                        .padding(.leading)
                        .font(.system(size: 24))
                    } else {
                        Button(action: {
                            newPerson = ""
                            self.isEditing = true
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add Person")
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
                NavigationLink(destination: GoodsInput()) {
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
            .offset(y: -UIScreen.main.bounds.height/2.5)
            
            NavigationLink(destination: CreditsSelection()) {
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
    
    private func addPerson() {
        if !newPerson.isEmpty {
            people.append(newPerson)
        }
        newPerson = ""
        print(people)
    }
}

#Preview {
    PeopleInput()
}
