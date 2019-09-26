//
//  NewsModelTests.swift
//  All About Today Tests
//
//  Created by Kushal Mukherjee on 25/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import XCTest
@testable import All_About_Today

class NewsModelTests: XCTestCase {

    var newsData: NewsData!
    override func setUp() {
        fetchNews()
        super.setUp()
    }

    override func tearDown() {
        newsData = nil
        super.tearDown()
    }
    
    
    func testNewsDataAvailable(){
        
        XCTAssertNotNil(self.newsData)
    }
    
    func testNewsDataUnavailable(){
        let promise = expectation(description: "fetching headlines without topic")
        APIManager.shared.fetchTopHeadlines(topic: "") { (data, err) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            do{
                XCTAssertThrowsError(try decoder.decode(NewsData.self, from: data))
                promise.fulfill()
            }
            catch{
                
            }
        }
        wait(for: [promise], timeout: 5)
       }
    
    
    func testNewsArticlesPresent(){
        
        XCTAssertFalse(newsData.articles.isEmpty)
        
    }
    
    
    
    fileprivate func fetchNews(topic: String = "top-headlines") {
        let promise = expectation(description: "fetching headlines")
        APIManager.shared.fetchTopHeadlines(topic: topic) { (data, err) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            do{
                self.newsData = try decoder.decode(NewsData.self, from: data)
                promise.fulfill()
            }
            catch{
                print(error.localizedDescription)
            }
        }
        wait(for: [promise], timeout: 5)
    }
    

}
