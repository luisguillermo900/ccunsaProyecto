//
//  CreateAccountView.swift
//  ccunsaProyecto
//
//  Created by epismac on 7/10/24.
//

import SwiftUI
import CoreData

import SwiftUI
import CoreData

struct CreateAccountView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        Form {
            Section(header: Text("Información personal")) {
                TextField("Nombre", text: $firstname)
                TextField("Apellido", text: $lastname)
                TextField("Email", text: $email)
                TextField("Teléfono", text: $phone)
            }

            Section(header: Text("Datos de la cuenta")) {
                TextField("Nombre de usuario", text: $username)
                SecureField("Contraseña", text: $password)
            }

            Button("Crear cuenta") {
                createAccount()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Crear cuenta")
    }

    func createAccount() {
        // Aquí se agrega la cuenta a Core Data
        let dataController = DataController()
        dataController.addUser(firstName: firstname, lastName: lastname, email: email, phone: phone, userName: username, password: password, context: managedObjectContext)
    }
}
