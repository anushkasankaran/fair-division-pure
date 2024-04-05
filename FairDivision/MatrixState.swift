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
    
    func setSize(peopleCount: Int, goodsCount: Int) {
        self.matrix = Array(repeating: Array(repeating: 0, count: goodsCount), count: peopleCount)
        self.totalCredits = Array(repeating: goodsCount * 10, count: peopleCount)
    }
    
    func setValue(rowIndex: Int, columnIndex: Int, value: Int) {
        // Check if rowIndex and columnIndex are within bounds
        guard rowIndex >= 0 && rowIndex < matrix.count && columnIndex >= 0 && columnIndex < matrix[rowIndex].count else {
            return
        }
        if (value < 0 || (rowIsComplete(rowIndex: rowIndex) && value > matrix[rowIndex][columnIndex])) {
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
}
