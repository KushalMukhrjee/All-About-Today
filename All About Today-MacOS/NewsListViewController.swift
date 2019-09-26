//
//  NewsListViewController.swift
//  All About Today-MacOS
//
//  Created by Kushal Mukherjee on 24/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import Cocoa

class NewsListViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var newsTable: NSTableView!
    
    @IBOutlet weak var searchField: NSSearchField!
    var newsDetailVC = NewsDetailViewController()
    
    var newsArray = [NewsData.NewsModel]()
    
    var mainWindowController: WindowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        newsTable.dataSource = self
        newsTable.delegate = self
        newsTable.rowHeight = 75
        searchField.delegate = self
        
    }
    override func viewWillAppear() {
        fetchNews()
        searchField.stringValue = ""
        
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = newsTable.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NewsListCell
        cell.wrappingLabelField.stringValue = newsArray[row].title
        cell.wrappingLabelField.font = NSFont(name: "HelveticaNeue-CondensedBold", size: 14)
        return cell
    }
    
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        let selectedArticle = newsArray[newsTable.selectedRow]
        
        let rowView = newsTable.rowView(atRow: newsTable.selectedRow, makeIfNecessary: false)
        
        rowView?.isEmphasized = true
        
        newsDetailVC = self.parent?.children[1] as! NewsDetailViewController
        newsDetailVC.article = selectedArticle
        
        
    }
    
    func fetchNews(topic: String = "top-headlines"){
        
        APIManager.shared.fetchTopHeadlines(topic: topic) { (data,err) in

            guard let data = data else {return}

            let decoder = JSONDecoder()
            do{
                let newsData = try decoder.decode(NewsData.self, from: data)
                self.newsArray = newsData.articles
                DispatchQueue.main.async {
                    self.newsTable.reloadData()
                    self.newsTable.selectRowIndexes(IndexSet(arrayLiteral: 0), byExtendingSelection: true)
                }
            }
            catch{
                print("Error parsing json:",error.localizedDescription)
            }
        }
        
    }
    
}

extension NewsListViewController: NSSearchFieldDelegate{
   
    func controlTextDidChange(_ obj: Notification) {
        if searchField.stringValue.isEmpty{
            fetchNews()
        }

    }
    
    
    
    func controlTextDidEndEditing(_ obj: Notification) {

        if searchField.stringValue.isEmpty{
            fetchNews()
        }
        else{
            fetchNews(topic: searchField.stringValue)
        }
    }

}
