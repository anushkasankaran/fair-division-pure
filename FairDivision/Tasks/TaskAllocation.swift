//
//  TaskAllocation.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 4/12/24.
//

import SwiftUI

struct TaskAllocation: View {
    @ObservedObject var matrixState: TaskMatrix
    @Binding var tasks: [Good]
    @Binding var people: [Agent]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    Spacer().frame(height: UIScreen.main.bounds.height/10)
                    ForEach(Array(people.enumerated()), id: \.offset) {index, person in
                        Text(person.name)
                            .font(.title)
                            .underline()
                            .padding(.bottom, 10)
                        ForEach(matrixState.optAlloc[index], id: \.self) { taskIndex in
                            Text(tasks[taskIndex].name)
                                .padding(.bottom, 10)
                        }
                    }
                }
                
                ZStack {
                    Rectangle()
                        .frame(height: UIScreen.main.bounds.height/6.5)
                        .ignoresSafeArea()
                        .foregroundColor(Color(hex: 0xFBF8F0))
                        .blur(radius: 8)
                    NavigationLink(destination: LandingChoice(selection: .constant(2)).navigationBarBackButtonHidden(true)) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .foregroundColor(.black)
                    }
                    Text("Allocation")
                        .font(.system(size: 40))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .offset(y: -UIScreen.main.bounds.height/2.7)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color(hex: 0xFBF8F0).ignoresSafeArea()
            }
        }
    }
}

#Preview {
    TaskAllocation(matrixState: TaskMatrix(), tasks: .constant([]), people: .constant([]))
}
