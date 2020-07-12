//
//  Constant.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import UIKit

struct SystemConstant {
    static let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    
    static let APIResponseLimit = 10
    static let appDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

struct API {
    
    /// Generate abaseURL from API's Endpoint including API's route
    static let BaseUrl = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/"
    
    struct Paths {
        static let article = "blogs?"
    }
    
    /// All the headers keys for Alamofire modal.
    struct Headers {
        static let Authorization = "Authorization"
        static let CacheControl = "Cache-Control"
        static let ContentType = "Content-Type"
    }
}
