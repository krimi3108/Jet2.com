//
//  CoreDataHelper.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import Foundation
import CoreData
public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
class CoreDataHelper: NSObject {

    static let instance = CoreDataHelper()
    private override init() {}
    
    var context: NSManagedObjectContext {
        let context = SystemConstant.appDelegate.persistentContainer.viewContext
        return context
    }

    func fetchRequest<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate? = nil, sort: NSSortDescriptor? = nil) -> [T]? {
        let entityName = NSStringFromClass(entityClass)
        let request    = NSFetchRequest<T>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        do {
            let fetchedResult = try context.fetch(request)
            return fetchedResult
        } catch let error {
            print("errore: \(error.localizedDescription)")
        }
        return nil
    }
}
