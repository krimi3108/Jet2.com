//
//  Article+CoreDataClass.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject, Decodable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }
    
    @NSManaged public var comments: Int64
    @NSManaged public var content: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var id: String?
    @NSManaged public var likes: Int64
    @NSManaged public var user: User?
    @NSManaged public var media: Media?
    
    enum CodingKeys: String, CodingKey {
        case comments
        case content
        case createdAt
        case id
        case likes
        case user
        case media
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let comments =  try? container.decode(Int?.self, forKey: .comments) {
                self.comments = Int64(comments)
            } else {
                self.comments = 0
            }
            
            content = try container.decode(String.self, forKey: .content)
            createdAt = try container.decode(String.self, forKey: .createdAt)
            id = try container.decode(String.self, forKey: .id)
            if let likes =  try? container.decode(Int?.self, forKey: .likes) {
                self.likes = Int64(likes)
            } else {
                self.likes = 0
            }
            if let user = try container.decode([User]?.self, forKey: .user) {
                print(user)
                self.user = user.first
            }
            if let media = try container.decode([Media]?.self, forKey: .media) {
                print(media)
                self.media = media.first
            }

//            user?.append(contentsOf: try container.decode([User].self, forKey: .user))
//            media = try container.decode([Media].self, forKey: .media)
        } catch {
            print(error)
        }
    }
}

// MARK: Generated accessors for user
extension Article {
    
    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)
    
    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)
    
    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)
    
    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)
    
}

// MARK: Generated accessors for media
extension Article {
    
    @objc(addMediaObject:)
    @NSManaged public func addToMedia(_ value: Media)
    
    @objc(removeMediaObject:)
    @NSManaged public func removeFromMedia(_ value: Media)
    
    @objc(addMedia:)
    @NSManaged public func addToMedia(_ values: NSSet)
    
    @objc(removeMedia:)
    @NSManaged public func removeFromMedia(_ values: NSSet)
    
}
