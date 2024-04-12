//
//  TaskCreditInput.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 4/12/24.
//

import SwiftUI

struct TaskCreditInput: View {
    var agent: Agent
    var index: Int
    @ObservedObject var matrixState: TaskMatrix
    @State var inputs: [Int] = []
    @State private var stepperValue: Int = 0
    @Binding var goods: [Good]
    @Binding var people: [Agent]
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/6.5)
                    ForEach(Array(goods.enumerated()), id: \.offset) { i, good in
                        HStack {
                            Text(good.name)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            
                            HStack {
                                Button(action: {
                                    decreaseStepper(i: i)
                                }) {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.white)
                                            .shadow(radius: 5)
                                        Text("-")
                                            .foregroundColor(.black)
                                    }
                                }
                                
                                TextField("--", text: Binding(
                                    get: {
                                        "\(matrixState.getValue(rowIndex: index, columnIndex: i))"
                                    },
                                    set: { newValue in
                                        if let intValue = Int(newValue) {
                                            matrixState.setValue(rowIndex: index, columnIndex: i, value: intValue)
                                        }
                                    }
                                ))
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                    .frame(maxWidth: 60)
                                    .multilineTextAlignment(.center)
                                
                                Button(action: {
                                    increaseStepper(i: i)
                                }) {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.white)
                                            .shadow(radius: 5)
                                        Text("+")
                                            .foregroundColor(.black)
                                    }
                                }
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
                    NavigationLink(destination: TaskCreditsSelection(matrixState: matrixState, goods: $goods, people: $people).navigationBarBackButtonHidden(true)) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .foregroundColor(.black)
                    }
                    VStack {
                        Text(agent.name)
                            .font(.system(size: 40))
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("A smaller number of credits indicates an easier task")
                            .foregroundColor(Color(hex: 0x707070))
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                    }
                    .offset(y: 20)
                    
                    Text("Credits: \(matrixState.getRemainingCredits(rowIndex: index))")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing)
                }
                .offset(y: -UIScreen.main.bounds.height/2.65)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color(hex: 0xFBF8F0).ignoresSafeArea()
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
    private func increaseStepper(i: Int) {
        matrixState.setValue(rowIndex: index, columnIndex: i, value: matrixState.getValue(rowIndex: index, columnIndex: i) + 1)
    }
    
    private func decreaseStepper(i: Int) {
        matrixState.setValue(rowIndex: index, columnIndex: i, value: matrixState.getValue(rowIndex: index, columnIndex: i) - 1)
    }
}

#Preview {
    TaskCreditInput(agent: Agent(name: "Hello"), index: 0, matrixState: TaskMatrix(), goods: .constant([
        Good(name: "Good 1"),
        Good(name: "Good 2"),
        Good(name: "Good 3")
    ]), people: .constant([
        Agent(name: "Hello"), Agent(name: "World")
    ]))
}
