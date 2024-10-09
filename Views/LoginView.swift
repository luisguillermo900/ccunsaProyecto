//
//  LoginView.swift
//  ccunsaProyecto
//
//  Created by epismac on 7/10/24.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Binding var isLoggedin: Bool
    @Environment(\.managedObjectContext) var managedObjContext // Aquí debería estar
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            ZStack{			
                Image("fondo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 2000, height: 900)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("CCUNSA")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 100)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.white),
                            alignment: .bottom
                        )
                    
                    TextField("Usuario", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                    
                    
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        
                    }){
                        Text("¿Olvidaste tu contraseña?")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.blue)
                            .underline()
                    }
                    .padding(.top, 20)
                    
                    
                    Button("Iniciar Sesión", action: btnLogin)
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 10)

                    NavigationLink(destination: CreateAccountView()) {
                        Text("Crear cuenta")
                            .padding(.top, 10)
                    }
                }
                .navigationTitle("Login")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(false)
            }
            
        }
    }

    func btnLogin() {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "userName == %@ AND password == %@", username, password)
        do {
            let accounts = try managedObjContext.fetch(fetchRequest)
            if !accounts.isEmpty {
                isLoggedin = true
            } else {
                print("usuario y contraseña incorrecto")
            }
        } catch {
            print("Error al buscar cuentas: \(error.localizedDescription)")
        }
    }
}
