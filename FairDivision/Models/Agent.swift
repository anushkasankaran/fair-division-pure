//
//  Models.swift
//  FairDivision
//
//  Created by Srikar on 3/1/24.
//

import Foundation

// Model for agents
struct Agent: Identifiable {
    let id = UUID()
    let name: String
    var goods: [GoodValue] = [] // Stores values for goods
}
