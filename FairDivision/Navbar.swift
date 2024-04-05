//
//  Navbar.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 4/5/24.
//

import SwiftUI

struct Navbar: View {
    @State var selected: Int
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    self.selected = 0
                }) {
                    Image(systemName: self.selected == 0 ? "list.bullet.clipboard.fill" : "list.bullet.clipboard")
                        .padding(.trailing, 30)
                        .padding(.leading, 25)
                        .foregroundColor(.black)
                }
                Button(action: {
                    self.selected = 1
                }) {
                    Image(systemName: self.selected == 1 ? "house.fill" : "house")
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                }
                Button(action: {
                    self.selected = 2
                }) {
                    Image(systemName: self.selected == 2 ? "cart.fill" : "cart")
                        .padding(.leading, 30)
                        .padding(.trailing, 25)
                        .foregroundColor(.black)
                }
            }
            .padding()
            .background(.thickMaterial)
            .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
}

#Preview {
    Navbar(selected: 1)
}
