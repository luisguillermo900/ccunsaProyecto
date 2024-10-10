//
//  ccunsaProyectoApp.swift
//  ccunsaProyecto
//
//  Created by epismac on 7/10/24.
//

import SwiftUI

@main
struct ccunsaProyectoApp: App {
    @State var isLoggedin: Bool = false
    @State private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            if isLoggedin {
                MainTabView(isLoggedin: $isLoggedin)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            } else {
                LoginView(isLoggedin: $isLoggedin)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}

