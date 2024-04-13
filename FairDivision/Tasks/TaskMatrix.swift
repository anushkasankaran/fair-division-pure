//
//  TaskMatrix.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 4/12/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class TaskMatrix: ObservableObject {
    @Published var matrix: [[Int]] = []
    @Published var totalCredits: [Int] = []
    @Published var optAlloc: [[Int]] = []
    
    func setSize(peopleCount: Int, goodsCount: Int) {
        self.matrix = Array(repeating: Array(repeating: 0, count: goodsCount), count: peopleCount)
        self.totalCredits = Array(repeating: goodsCount * 10, count: peopleCount)
    }
    
    func setValue(rowIndex: Int, columnIndex: Int, value: Int) {
        // Check if rowIndex and columnIndex are within bounds
        guard rowIndex >= 0 && rowIndex < matrix.count && columnIndex >= 0 && columnIndex < matrix[rowIndex].count else {
            return
        }
        let maxVal = totalCredits[rowIndex] + matrix[rowIndex][columnIndex]
        if (value < 0 || (rowIsComplete(rowIndex: rowIndex) && value > matrix[rowIndex][columnIndex]) || value > maxVal) {
            return
        }
        totalCredits[rowIndex] -= value - matrix[rowIndex][columnIndex]
        matrix[rowIndex][columnIndex] = value
    }
    
    func getValue(rowIndex: Int, columnIndex: Int) -> Int {
        // Check if rowIndex and columnIndex are within bounds
        guard rowIndex >= 0 && rowIndex < matrix.count && columnIndex >= 0 && columnIndex < matrix[rowIndex].count else {
            print("Out of bounds: Matrix length is ", matrix.count)
            print("Passed in values are ", rowIndex, ", ", columnIndex)
            return 0 // Return a default value if index is out of bounds
        }
        return matrix[rowIndex][columnIndex]
    }
    
    func isComplete() -> Bool {
        let columnsCount = matrix.first?.count ?? 0
        
        for row in matrix {
            if row.reduce(0, +) != 10 * columnsCount {
                return false
            }
        }
        return true
    }
    
    func rowIsComplete(rowIndex: Int) -> Bool {
        let columnsCount = matrix.first?.count ?? 0
        if (rowIndex < 0 || rowIndex >= totalCredits.count) {
            return true
        }
        return (matrix[rowIndex].reduce(0, +) == 10 * columnsCount)
    }
    
    func getRemainingCredits(rowIndex: Int) -> Int {
        guard rowIndex >= 0 && rowIndex < totalCredits.count else {
            print("Out of bounds: Credits array length is ", totalCredits.count)
            print("Passed in values is ", rowIndex)
            return 0
        }
        return totalCredits[rowIndex]
    }
    
    func roundRobin(agents: [Agent], items: [Good]) {
        addSession(people: agents, tasks: items)
        
        self.optAlloc = Array(repeating: Array(), count: agents.count)
        var selectedGoods: [Int] = []
        var alteredMatrix = matrix.map { $0.map { $0 } }
        while selectedGoods.count < items.count {
            for i in 0...(agents.count - 1) {
                let favIndex = alteredMatrix[i].firstIndex(of: alteredMatrix[i].min() ?? -1) // Get index of easiest task
                // Remove this task as an option for each agent
                for row in 0...(alteredMatrix.count - 1) {
                    alteredMatrix[row][favIndex!] = items.count * 10 + 1
                }
                // Give this task to this agent
                optAlloc[i].append(favIndex!)
                // Add this task to already selected tasks
                selectedGoods.append(favIndex!)
                // Make sure stops if tasks run out
                if selectedGoods.count >= items.count {
                    break
                }
            }
        }
        
        print(optAlloc)
    }
    
    func addSession(people: [Agent], tasks: [Good]) {
        let db = Firestore.firestore()
        
        // Used to set value for "isGood"
        let type = false
        
        // Convert valuation matrix into one dimension
        var onedval: [Int] = []
        for i in 0..<matrix.count {
            for j in 0..<matrix[0].count {
                onedval.append(matrix[i][j])
            }
        }
        
        var people_: [String] = []
        for person in people {
            people_.append(person.name)
        }
        
        var tasks_: [String] = []
        for task in tasks {
            tasks_.append(task.name)
        }
        
        db.collection("inputs").document("Session " + UUID().uuidString).setData([
            "agents" : people_, 
            "items" : tasks_,
            "isGood" : type,
            "valuation" : onedval
        ])
    }
}
