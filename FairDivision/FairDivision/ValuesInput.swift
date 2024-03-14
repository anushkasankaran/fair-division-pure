////
////  ValuesInput.swift
////  FairDivision
////
////  Created by Srikar on 3/1/24.
////
//
//import SwiftUI
//
//struct ValuesInput: View {
//    var body: some View {
//        NavigationView {
//            List(agents) { agent in
//                NavigationLink(destination: AgentGoodsView(agent: agent)) {
//                    Text(agent.name)
//                }
//            }
//            .navigationBarTitle("Agents")
//        }
//    }
//}
//
//struct AgentGoodsView: View {
//    @State var agent: Agents
//    
//    
//    var body: some View {
//        VStack {
//            Text("Enter values for \(agent.name)")
//                .font(.headline)
//                .padding()
//            
//            List {
//                ForEach(agent.goods.indices, id: \.self) { index in
//                    Stepper(
//                        value: self.binding(for: index),
//                        in: 0...25,
//                        label: {
//                            Text("\(self.agent.goods[index].good.name): \(self.agent.goods[index].value)")
//                        }
//                    )
//                }
//            }
//        }
//        .navigationBarTitle("\(agent.name)'s Goods")
//    }
//    
//    private func binding(for index: Int) -> Binding<Int> {
//        return Binding<Int>(
//            get: { self.agent.goods[index].value },
//            set: { newValue in
//                let cappedValue = min(max(0, newValue), 25) // Cap the value between 0 and 25
//                self.agent.goods[index].value = cappedValue
//            }
//        )
//    }
//}
//
//#Preview {
//    ValuesInput()
//}
