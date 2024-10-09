//
//  DataController.swift
//  ccunsaProyecto
//
//  Created by epismac on 7/10/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ccunsaModel")
    
    init(){
        container.loadPersistentStores { desc, error in
            if let error = error{
                print("Falló la carga de data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved")
        }catch{
            print("Not data saved")
        }
    }
    func addUser(firstName: String, lastName: String, email: String, phone: String, userName: String, password: String, context: NSManagedObjectContext){
        let account = Account(context: context)
        account.id = UUID()
        account.firstName = firstName
        account.lastName = lastName
        account.email = email
        account.phone = phone
        account.userName = userName
        account.password = password
        
        save(context: context)
    }
    
    
}
