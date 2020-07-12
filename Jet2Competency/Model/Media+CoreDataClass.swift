//
//  Media+CoreDataClass.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Media)
public class Media: NSManagedObject, Decodable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
          return NSFetchRequest<Media>(entityName: "Media")
      }

      @NSManaged public var blogId: String?
      @NSManaged public var createdAt: String?
      @NSManaged public var id: String?
      @NSManaged public var image: String?
      @NSManaged public var title: String?
      @NSManaged public var url: String?

    
    enum CodingKeys: String, CodingKey {
        case blogId
        case createdAt
        case id
        case image
        case title
        case url
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
        let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: "Media", in: managedObjectContext) else {
            fatalError("Failed to decode User")
    }
        self.init(entity: entity, insertInto: managedObjectContext)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            blogId = try container.decode(String?.self, forKey: .blogId)
            createdAt = try container.decode(String.self, forKey: .createdAt)
            id = try container.decode(String.self, forKey: .id)
            image = try container.decode(String.self, forKey: .image)
            title = try container.decode(String.self, forKey: .title)
            url = try container.decode(String.self, forKey: .url)
        } catch {
            print(error)
        }
    }
}
