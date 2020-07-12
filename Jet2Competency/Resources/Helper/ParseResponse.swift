//
//  ParseResponse.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import Foundation

struct GenericFunctions {
    
    static func parseCoreDataAPI<Element: Decodable>(response: Data) -> Element? {
        var dataModal: Element?
        do {
            let json = try JSONSerialization.jsonObject(with: response, options: []) as? [[String: Any]]

            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let jsonDecoder = JSONDecoder()
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve context")
            }
            let managedObjectContext =  SystemConstant.appDelegate.persistentContainer.viewContext
            jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            dataModal = try jsonDecoder.decode(Element.self, from: jsonData)
        } catch {
            print(error)
            return nil
        }
        return dataModal
    }
}
