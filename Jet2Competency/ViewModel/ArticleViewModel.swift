//
//  ArticleViewModel.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import Foundation

class ArticleViewModel: NSObject {
    
    // MARK:- API Calls
    func requestForScheduleData(offset: Int, callback: @escaping (Result<Any?, NetworkError>) -> Void) {
        let endpointURL = API.BaseUrl + API.Paths.article + "page=\(offset)&limit=\(SystemConstant.APIResponseLimit)"
        
        APIManager.callAPI(urlString: endpointURL, params: nil) { response in
            switch response {
            case .success(let response):
                // Core Data stuff
                if let parsedData: [Article] = GenericFunctions.parseCoreDataAPI(response: response as! Data) {
                    //self.parseData(data) {

                    try? CoreDataHelper.instance.context.save()
                    
                    callback(.success(parsedData))
                } else {
                    callback(.failure(.badRequest))
                    
                }
            case .failure(let error):
                if error == NetworkError.badRequest {
                    if let articleList = CoreDataHelper.instance.fetchRequest(entityClass: Article.self) {
                        try? CoreDataHelper.instance.context.save()
                        callback(.success(articleList))
                    }
                } else {
                    callback(.failure(error))
                }
                
            }
        }
    }
    
    //    func parseData(_ data: Data) -> [Article]? {
    //        var scheduleData: [Article]?
    //        do {
    //            //try to parse respone
    //            let jsonDecoder = JSONDecoder()
    //            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    //
    //            scheduleData = try jsonDecoder.decode([Article].self, from: data)
    //            return scheduleData
    //        } catch {
    //            return nil
    //        }
    //    }
}
