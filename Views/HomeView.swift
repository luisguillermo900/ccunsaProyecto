import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest var account: FetchedResults<Account>
    
    @State private var userName: String = "159"
    @State private var password: String = "159"
    
    init() {
        // Usa el nombre de usuario para inicializar la FetchRequest
        let predicate = NSPredicate(format: "userName == %@", "159")
        _account = FetchRequest<Account>(sortDescriptors: [], predicate: predicate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let userAccount = account.first {
                Text("Bienvenido, \(userAccount.firstName ?? "Usuario")!")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                
            } else {
                Text("No se encontró la cuenta.")
            }
        }
        .navigationTitle("Home")
        .onAppear {
            validateLogin()
        }
    }
    
    private func validateLogin() {
        if let userAccount = account.first {
            if userAccount.password == password {
                
                print("Ingreso exitoso")
            } else {
                
                print("Contraseña incorrecta")
            }
        }
    }
}
