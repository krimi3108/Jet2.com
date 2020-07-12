//
//  BaseViewController.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - View Controller life cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BaseViewController {
    
    // MARK: - Navigation Bar
    /** Set Navigation bar appreance. */
    func setNavigationBar(title: String) {
        self.navigationController?.navigationBar.barTintColor =  UIColor(named: "CellBG")
        setNavigationBarTitle(text: title)
    }
    
    // MARK: - Navigation Title
    /**
     Set Navigation title
     - parameter text: A string to be set on navigation title.
     */
    public func setNavigationBarTitle(text: String) {
        self.navigationItem.title = text
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .black)]
    }
    
    /// MARK: - Left back button
    /**
     Set Back button on Navigation bar
     - parameter image: A image of navigation left bar (if any)
     */
    public func addBackBtn(title: String) {
        let leftBarBtn = UIButton()
        leftBarBtn.setTitle(title, for: .normal)
        leftBarBtn.setTitleColor(.white, for: .normal)
        leftBarBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        leftBarBtn.addTarget(self, action: #selector(actionBackButton), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarBtn)
    }
    
    /**
     Navigation back button action.
     */
    @objc func actionBackButton() {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Right bar button
    /**
     Set Right bar button(image) on Navigation bar
     - parameter image: A image of navigation left bar
     */
    public func addRightBarBtnWithImage(title: String, tag: Int = 0) {
        let rightBarBtn = UIButton()
        rightBarBtn.tag = tag
        rightBarBtn.setTitle(title, for: .normal)
        rightBarBtn.setTitleColor(.white, for: .normal)
        rightBarBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightBarBtn.addTarget(self, action: #selector(actionRightBarButton), for: .touchUpInside)
        
        if let rightBarButtons = self.navigationItem.rightBarButtonItems {
            var existingBtnArr = rightBarButtons
            existingBtnArr.append(UIBarButtonItem.init(customView: rightBarBtn))
            self.navigationItem.rightBarButtonItems = existingBtnArr
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarBtn)
        }
    }
    
       /**
     Navigation right bar button action.
     */
    @objc func actionRightBarButton(sender: Any) {
    }
    
}
