//
//  FairDivisionApp.swift
//  FairDivision
//
//  Created by Srikar on 2/23/24.
//

import SwiftUI

@main
struct FairDivisionApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            PeopleInput().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
