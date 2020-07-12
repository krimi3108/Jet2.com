//
//  UIView+Extension.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import UIKit

extension UIView {
    
    func noDataView(with message: String, image: UIImage? = nil) -> UIView {
        let noDataView = UILabel()
        noDataView.frame = CGRect(origin: self.center, size: CGSize(width: self.frame.width, height: 30))
        noDataView.textAlignment = .center
        noDataView.text =  message
        return noDataView
    }
}
