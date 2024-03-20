//
//  PeopleInput.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/2/24.
//

import SwiftUI
import CoreData

struct PeopleInput: View {
    //    Change people to binding var to allow credit selection page to use
    //    @State private var people: [Agents] = [
    //        Agents(name: "Hello"), Agents(name: "World")
    //    ]
    @State private var isEditing: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Agent.entity(), sortDescriptors: []) private var agents: FetchedResults<Agent>
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/9)
                    ForEach(agents, id: \.self) { agent in
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(20)
                                .shadow(radius: 7)
                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/14)
                            Text(agent.name ?? "Unknown")
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .frame(width: UIScreen.main.bounds.width - 40)
                            Button(action: {
                                if let index = agents.firstIndex(where: { $0.id == agent.id }) {
                                    viewContext.delete(agents[index])
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
                            @State var newPerson: String = ""
                            TextField("Enter Name", text: $newPerson, onCommit: {
                                self.addPerson(input: newPerson)
                                self.isEditing = false
                            })
                            .padding(.leading)
                            .font(.system(size: 24))
                        } else {
                            Button(action: {
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
                    NavigationLink(destination: GoodsInput().navigationBarBackButtonHidden(true)) {
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
                
                ZStack {
                    if (agents.count >= 2) {
                        NavigationLink(destination: CreditsSelection().navigationBarBackButtonHidden(true)) {
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color(hex: 0xFBF8F0).ignoresSafeArea()
            }
        }
    }
    
    private func addPerson(input: String) {
        let agent = Agent(context: viewContext)
        agent.id = UUID()
        agent.name = input
        try? viewContext.save()
        print(agents)
    }
}

#Preview {
    PeopleInput()
}
