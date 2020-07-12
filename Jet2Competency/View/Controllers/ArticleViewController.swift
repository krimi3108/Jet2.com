//
//  ViewController.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import UIKit


class ArticleViewController: BaseViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var articleListView: UITableView!
    
    // MARK:- Variables
    var listData: [Article]? {
        didSet {
            self.articleListView.reloadData()
        }
    }
    var refreshControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView()
    var articleVM = ArticleViewModel()
    var offset = 1 {
        didSet {
            callAPI()
        }
    }
    var isLoading = false
    var isPending = true
    
    // MARK:- Call API
    func callAPI() {
        
        if offset == 1 {
            self.activityIndicator.startAnimating()
        }
        
        articleVM.requestForScheduleData(offset: offset) { [weak self] response in
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
            
            switch response {
            case .success(let data):
                self?.isLoading = false
                guard let articles = data as? [Article], !articles.isEmpty else {
                    self?.isPending = false
                    return }
                
                if self?.listData == nil {
                    self?.listData = articles
                } else {
                    for article in articles {
                        if let data = self?.listData,  !data.contains(where: { (previousArticle) -> Bool in
                            previousArticle.id == article.id
                        }) {
                            self?.listData?.append(article)
                        }
                    }
                }
            case .failure(_):
                return
            }
        }
    }
    
    // MARK:- ViewController life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    // MARK:- View Methods
    func initializeView() {
        // Configre Navigation Bar
        self.setNavigationBar(title: "Articles")
        
        // Pull to refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        
        // Configure articleListView
        articleListView.tableFooterView = UIView()
        articleListView.estimatedRowHeight = 300
        articleListView.addSubview(refreshControl)
        
        // configure activity indicator
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.center = self.view.center
        self.articleListView.addSubview(activityIndicator)
        
        offset = 1
        
    }
    
    // MARK:- View Methods
    @objc func refresh(sender: AnyObject) {
        offset = 1
    }
    
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = listData?.count ?? 0
        
        if count > 0  {
            tableView.backgroundView = nil
        } else {
            tableView.backgroundView = tableView.noDataView(with: offset == 1 ? "" : "OOPS! No Article for Today")
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String.className(ArticleTableViewCell.self), for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
        
        cell.listData = listData?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = listData?.count,  indexPath.row > count - 4 && isPending, !isLoading {
            isLoading = true
            offset += 1
        }
    }
}
