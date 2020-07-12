//
//  UIImage+Extension.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from url: String, placeHolderImage: UIImage) {
        APIManager.callAPI(urlString: url, params: nil) { response in
            switch response {
            case .success(let imgData):
                DispatchQueue.main.async {
                    self.image = UIImage(data: imgData as! Data)
                }
            case .failure(_):
                self.image = placeHolderImage
            }
        }
    }
}
