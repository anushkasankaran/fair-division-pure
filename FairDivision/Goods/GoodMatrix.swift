//
//  MatrixState.swift
//  FairDivision
//
//  Created by Anushka Sankaran on 3/22/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFunctions

class GoodMatrix: ObservableObject {
    @Published var matrix: [[Int]] = []
    @Published var totalCredits: [Int] = []
    @Published var optAlloc: [[Int]] = []
    @Published var optNashWelfare: Double = -1.0
    
    private var db = Firestore.firestore()
    
    func setSize(peopleCount: Int, goodsCount: Int) {
        self.matrix = Array(repeating: Array(repeating: 0, count: goodsCount), count: peopleCount)
        self.totalCredits = Array(repeating: 100, count: peopleCount)
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
        if (matrix[rowIndex][columnIndex] == 0 && columnIndex == (matrix.first?.count ?? 0) - 1) {
            matrix[rowIndex][columnIndex] = maxVal
            totalCredits[rowIndex] = 0
        } else {
            totalCredits[rowIndex] -= value - matrix[rowIndex][columnIndex]
            matrix[rowIndex][columnIndex] = value
        }
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
        for row in matrix {
            if row.reduce(0, +) != 100 {
                return false
            }
        }
        return true
    }
    
    func rowIsComplete(rowIndex: Int) -> Bool {
        if (rowIndex < 0 || rowIndex >= totalCredits.count) {
            return true
        }
        return (matrix[rowIndex].reduce(0, +) == 100)
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
    
    func getMaxNashWelfare(agents: [Agent], items: [Good]) {
        addSession(people: agents, goods: items)
        
        let functions = Functions.functions()
        
        var myDict: [String: Any] = [String: Any]()
        myDict["agents"] = agents.count
        myDict["items"] = items.count
        myDict["values"] = matrix
                
        var allocation: [[Int]]?
        callCloudFunction(dict: myDict) { result in
            allocation = result
        }

        if let allocation = allocation {
            self.optAlloc = allocation
            print("Received allocations")
        } else {
            print("Error retrieving allocations from Cloud Function")
        }


//        let numAgents = agents.count
//        let numItems = items.count
//        for alloc in generateAllAllocations(numAgents: numAgents, numItems: numItems) {
//            var values = [Double]()
//            for i in 0..<numAgents {
//                let sumValue = alloc[i].reduce(0.0) { $0 + Double(matrix[i][$1]) }
//                values.append(sumValue)
//            }
//            let nashWelfare = values.reduce(1.0, *)
//            
//            if nashWelfare > optNashWelfare {
//                optNashWelfare = nashWelfare
//                optAlloc = alloc
//            }
//        }
        
        print(optAlloc)
    }
    
    func callCloudFunction(dict: [String: Any], completion: @escaping ([[Int]]?) -> Void) {
        let queue = DispatchQueue(label: "cloudFunctionCallQueue")

        queue.async {
            Functions.functions().httpsCallable("mnw").call(dict) { result, error in
                if let error = error {
                    print("Error calling Cloud Function:", error.localizedDescription)
                    completion(nil)
                    return
                }

                guard let data = result?.data as? [String: Any] else {
                    print("Unexpected response format from Cloud Function")
                    completion(nil)
                    return
                }

                guard let allocations = data["alloc"] as? [[Int]] else {
                    print("Missing 'alloc' key in Cloud Function response")
                    completion(nil)
                    return
                }

                completion(allocations)
            }
        }
    }


    func addSession(people: [Agent], goods: [Good]) {
        let db = Firestore.firestore()
        
        // Used to set value for "isGood"
        let type = true
        
        var dict: [String: [String: Int]] = [String: [String: Int]]()
        for i in 0..<matrix.count {
            let person = people[i]
            var insideDict: [String: Int] = [String: Int]()
            for j in 0..<matrix[i].count {
                insideDict[goods[j].name] = matrix[i][j]
            }
            dict[person.name] = insideDict
        }
        
        let doc = "Session " + UUID().uuidString
        db.collection("allocations").document(doc).setData([
            "isGood" : type,
        ])
        
        for (key, value) in dict {
            db.collection("allocations").document(doc).setData([
                key: value
            ], merge: true)
        }
    }
}
