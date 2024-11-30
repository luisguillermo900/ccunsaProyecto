//
//  Account+CoreDataProperties.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var userName: String?

}

extension Account : Identifiable {

}
