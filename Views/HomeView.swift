//
//  HomeView.swift
//  ccunsaProyecto
//
//  Created by epismac on 7/10/24.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "userName == %@" /* Aquí debes pasar el username del usuario actual */)) var account: FetchedResults<Account>

    var body: some View {
        VStack(alignment: .leading) {
            if let userAccount = account.first {
                Text("Bienvenido, \(userAccount.firstName ?? "Usuario")!")
                // Mostrar más información del usuario
            } else {
                Text("No se encontró la cuenta.")
            }
        }
        .navigationTitle("Account")
    }
}


