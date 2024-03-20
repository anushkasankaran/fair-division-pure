//
//  CreditsInput.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/8/24.
//

import SwiftUI

struct CreditsInput: View {
//    Change goods to take values from GoodsInput
    var agent: Agent
    @State var inputs: [Int] = []
    @State private var stepperValue: Int = 0
    @State private var goods: [Good] = [
        Good(name: "Hello"), Good(name: "World")
    ]
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Agent.entity(), sortDescriptors: []) private var agents: FetchedResults<Agent>
    @FetchRequest(entity: Good.entity(), sortDescriptors: []) private var goods: FetchedResults<Good>
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/7)
                    ForEach(goods) { good in
                        HStack {
                            Text(good.name)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            
                            HStack {
                                Button(action: {
                                    decreaseStepper()
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
                                
                                Text("\(stepperValue)")
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                
                                Button(action: {
                                    increaseStepper()
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
                    NavigationLink(destination: CreditsSelection().navigationBarBackButtonHidden(true)) {
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
    
    private func increaseStepper() {
        stepperValue += 1
    }
    
    private func decreaseStepper() {
        if (stepperValue > 0) {
            stepperValue -= 1
        }
    }
}

#Preview {
    CreditsInput(agent: Agent(name: "Hello"))
}
