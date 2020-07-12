//
//  User+CoreDataClass.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//
//

import Foundation
import CoreData


@objc(User)
public class User: NSManagedObject, Decodable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
           return NSFetchRequest<User>(entityName: "User")
       }

       @NSManaged public var about: String?
       @NSManaged public var avatar: String?
       @NSManaged public var blogId: String?
       @NSManaged public var city: String?
       @NSManaged public var createdAt: String?
       @NSManaged public var designation: String?
       @NSManaged public var id: String?
       @NSManaged public var lastname: String?
       @NSManaged public var name: String?

    enum CodingKeys: String, CodingKey {
        case about
        case avatar
        case blogId
        case city
        case createdAt
        case designation
        case id
        case lastname
        case name
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
        let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
            fatalError("Failed to decode User")
    }
        self.init(entity: entity, insertInto: managedObjectContext)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            about = try container.decode(String?.self, forKey: .about)
            avatar = try container.decode(String?.self, forKey: .avatar)
            blogId = try container.decode(String?.self, forKey: .blogId)
            city = try container.decode(String.self, forKey: .city)
            createdAt = try container.decode(String.self, forKey: .createdAt)
            designation = try container.decode(String.self, forKey: .designation)
            id = try container.decode(String.self, forKey: .id)
            lastname = try container.decode(String.self, forKey: .lastname)
            name = try container.decode(String.self, forKey: .name)
        } catch {
            print(error)
        }
    }
}
