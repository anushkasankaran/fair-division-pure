//
//  MatrixState.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/22/24.
//

import Foundation
import SwiftUI

class MatrixState: ObservableObject {
    @Published var matrix: [[Int]] = []
    @Published var totalCredits: [Int] = []
    @Published var optAlloc: [[Int]] = []
    @Published var optNashWelfare: Double = -1.0
    
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
    
    func generateOwnerVectors(numAgents: Int, numItems: Int) -> [[Int]] {
        let maxAllocNum = Int(pow(Double(numAgents), Double(numItems)))
        var ownerVectors = [[Int]]()
        
        for allocNum in 0..<maxAllocNum {
            var ownerVector = [Int]()
            var remainingAllocNum = allocNum
            
            for _ in 0..<numItems {
                ownerVector.append(remainingAllocNum % numAgents)
                remainingAllocNum /= numAgents
            }
            
            ownerVectors.append(ownerVector)
        }
        
        return ownerVectors
    }
    
    func generateAllAllocations(numAgents: Int, numItems: Int) -> [[[Int]]] {
        let ownerVectors = generateOwnerVectors(numAgents: numAgents, numItems: numItems)
        var allocations = [[[Int]]]()
        
        for ownerVector in ownerVectors {
            var alloc = Array(repeating: [Int](), count: numAgents)
            
            for j in 0..<numItems {
                alloc[ownerVector[j]].append(j)
            }
            
            allocations.append(alloc)
        }
        
        return allocations
    }
    
    func getMaxNashWelfare(numAgents: Int, numItems: Int) {
        for alloc in generateAllAllocations(numAgents: numAgents, numItems: numItems) {
            var values = [Double]()
            for i in 0..<numAgents {
                let sumValue = alloc[i].reduce(0.0) { $0 + Double(matrix[i][$1]) }
                values.append(sumValue)
            }
            let nashWelfare = values.reduce(1.0, *)
            
            if nashWelfare > optNashWelfare {
                optNashWelfare = nashWelfare
                optAlloc = alloc
            }
        }
        
        print(optAlloc)
    }
}
