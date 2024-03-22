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
    @State var goodsvalues: [GoodValue] = []
    @State private var stepperValue: Int = 0
    @State private var allocatedCredits: Int = 0
    @State private var availableCredits: Int = 100
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Good.entity(), sortDescriptors: []) private var goods: FetchedResults<Good>
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/7)
                    ForEach(goods) { good in
                        HStack {
                            Text(good.name ?? "Unknown")
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
                        Text(agent.name ?? "Unknown")
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
                ZStack {
                    if (goods.count >= 2) {
                        NavigationLink(destination: PeopleInput().navigationBarBackButtonHidden(true)) {
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
    CreditsInput(agent: Agent())
}
