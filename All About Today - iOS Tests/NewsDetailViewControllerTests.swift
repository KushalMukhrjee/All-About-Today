//
//  NewsDetailViewControllerTests.swift
//  All About Today Tests
//
//  Created by Kushal Mukherjee on 25/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import XCTest
@testable import All_About_Today

class NewsDetailViewControllerTests: XCTestCase {
    
    var newsData: NewsData!
    var sut: NewsDetailViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fetchNews()
        sut = NewsDetailViewController()
        sut.article = newsData.articles[0]
        sut.viewDidLoad()
        sut.viewDidAppear(true)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        newsData = nil
        sut = nil
        super.tearDown()
    }
    
    func testImageView(){
      
        if let _ = sut.article?.urlToImage{
            XCTAssertNotNil(sut.articleImageView)
        }
        else{
            XCTAssertEqual(sut.articleImageView.image, UIImage(named: "LoadingImage"))
        }
        
    }
    
    func testArticleDescription(){
        
        if let description = sut.article?.description{
            XCTAssertEqual(sut.articleDescription.text, description)
        }
        else{
            XCTAssertEqual(sut.articleDescription.text, "No description available. Click the link below for full story.")
        }
        
    }
    
    
    func testArticleUrl(){
        XCTAssertEqual(sut.articleUrl.currentTitle, sut.article?.url)
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
