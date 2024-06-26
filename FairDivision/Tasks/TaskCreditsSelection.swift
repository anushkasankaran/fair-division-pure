//
//  TaskCreditsSelection.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 4/12/24.
//

import SwiftUI

struct TaskCreditsSelection: View {
    @ObservedObject var matrixState: TaskMatrix
    @Binding var tasks: [Good]
    @Binding var people: [Agent]
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/6.5)
                    ForEach(Array(people.enumerated()), id: \.offset) {index, person in
                        NavigationLink (destination: TaskCreditInput(agent: person, index: index, matrixState: matrixState, tasks: $tasks, people: $people).navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Rectangle()
                                    .fill(.white)
                                    .cornerRadius(20)
                                    .shadow(radius: 7)
                                    .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/14)
                                Text(person.name)
                                    .font(.system(size: 24))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                    .frame(width: UIScreen.main.bounds.width - 40)
                                if matrixState.rowIsComplete(rowIndex: index) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                        .frame(maxWidth: UIScreen.main.bounds.width - 50, alignment: .trailing)
                                        .padding(.trailing)
                                } else {
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: UIScreen.main.bounds.width - 50, alignment: .trailing)
                                        .padding(.trailing)
                                }
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
                    NavigationLink(destination: TaskPeopleInput(tasks: $tasks).navigationBarBackButtonHidden(true)) {
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
                .offset(y: -UIScreen.main.bounds.height/2.7)
                
                ZStack {
                    if (matrixState.isComplete()) {
                        NavigationLink(destination: TaskAllocation(matrixState: matrixState, tasks: $tasks, people: $people).navigationBarBackButtonHidden(true)) {
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
                            matrixState.roundRobin(agents: people, items: tasks)
                        })
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
        }
    }
}

#Preview {
    TaskCreditsSelection(matrixState: TaskMatrix(), tasks: .constant([
        Good(name: "Good 1"),
        Good(name: "Good 2"),
        Good(name: "Good 3")
    ]), people: .constant([
        Agent(name: "Hello"), Agent(name: "World")
    ]))
}
