//
//  ViewController.swift
//  All About Today
//
//  Created by Kushal Mukherjee on 22/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var newsTable: UITableView!
    var searchController: UISearchController!
    private let activityIndicator = UIActivityIndicatorView()
    private let refreshControll = UIRefreshControl()
    
    var newsArray = [NewsData.NewsModel]()
    var todaysHeadlineArray = [NewsData.NewsModel]()
    
    func configureAccessibility(){
        searchController.searchBar.isAccessibilityElement = true
        searchController.searchBar.accessibilityLabel = "Search"
        searchController.searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
    
        activityIndicator.isAccessibilityElement = false
        
        
    }
    fileprivate func setupNewsTable() {
        newsTable = UITableView()
        newsTable.rowHeight = 300
        self.view.addSubview(newsTable)
        newsTable.delegate = self
        newsTable.dataSource = self
        
        newsTable.translatesAutoresizingMaskIntoConstraints = false
        newsTable.pinToEdges(of: self.view)
        newsTable.register(NewsTableViewCell.self, forCellReuseIdentifier: "newscell")
        
        
        refreshControll.addTarget(self, action: #selector(refreshTable),for: .valueChanged)
        newsTable.refreshControl = refreshControll
    }
    
    
    
    
    
    
    @objc private func refreshTable(){
        
        guard let searchTopic = searchController.searchBar.text else {return}
        
        if searchTopic.isEmpty{
            fetchNews()
        }
        else{
            fetchNews(topic: searchTopic)
        }
    }
    
    
    
    
    
    
    fileprivate func fetchNews(topic: String = "top-headlines") {
        
        
        self.activityIndicator.startAnimating()
        APIManager.shared.fetchTopHeadlines(topic: topic) { (data, err) in
            
            if err != nil {
                let alertVc = UIAlertController(title: "Connection failed", message: "Please ensure you have a working internet connection.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                    self.fetchNews()
                    
                })
                alertVc.addAction(okButton)
                self.present(alertVc, animated: true, completion: nil)
            }
            
            let decoder = JSONDecoder()
            do{
                guard let data = data else {return}
                let newsData = try decoder.decode(NewsData.self, from: data)
                
                self.newsArray = newsData.articles
                if topic == "top-headlines"{
                    self.todaysHeadlineArray = self.newsArray
                }
                
                DispatchQueue.main.async {
                    self.refreshControll.endRefreshing()
                    self.activityIndicator.stopAnimating()
                    self.newsTable.reloadData()
                    
                }
            }
            catch{
                print("Error parsing JSON:",error.localizedDescription)
            }
            
        }
    }
    
    fileprivate func configureViewElements() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation=false
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        
        
        
        self.navigationItem.searchController = self.searchController
        
        definesPresentationContext = true
        
        self.activityIndicator.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        self.activityIndicator.style = .white
        self.activityIndicator.color = UIColor.darkGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Top News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNewsTable()
        
        configureViewElements()
        
        self.view.addSubview(activityIndicator)
        
        fetchNews()
        configureAccessibility()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let textfield = searchController.searchBar.value(forKey: "searchField") as! UITextField
        textfield.textColor = .white
    }
}


extension FirstViewController: UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTopic = searchBar.text{
            print("Search topic is:",searchTopic)
            fetchNews(topic: searchTopic)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.newsArray = self.todaysHeadlineArray
        newsTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTable.dequeueReusableCell(withIdentifier: "newscell", for: indexPath) as! NewsTableViewCell
        
        cell.article = newsArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        newsTable.deselectRow(at: indexPath, animated: true)
        let newsDetailViewController = NewsDetailViewController()
        newsDetailViewController.article = newsArray[indexPath.row]
        
        self.navigationController?.pushViewController(newsDetailViewController, animated: true)
             
    }
    
    
    
}



























