//
//  Models.swift
//  FairDivision
//
//  Created by Srikar on 3/1/24.
//

import Foundation

struct Good: Identifiable {
    let id = UUID()
    let name: String
}

// Model for agents
struct Agent: Identifiable {
    let id = UUID()
    let name: String
    var goods: [GoodValue] = [] // Stores values for goods
}

// Model for holding value for each good by an agent
struct GoodValue: Identifiable {
    let id = UUID()
    let good: Good
    var value: Int
}
