//
//  APIManager.swift
//  All About Today
//
//  Created by Kushal Mukherjee on 22/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import Foundation

//let API_KEY = "Insert you API key here."

class APIManager{
    
    static let shared = APIManager()
    
    fileprivate func searchUrl(baseURL: String,for topic: String) -> URL? {
        var urlComponent = URLComponents(string: baseURL)
        let queryItem1 = topic == "top-headlines" ? URLQueryItem(name: "country", value: "in") : URLQueryItem(name: "q", value: topic)
        let queryItem2 = URLQueryItem(name: "apiKey", value: API_KEY)
        urlComponent?.queryItems = [queryItem1,queryItem2]
        
        return urlComponent?.url
    }
    
    func fetchTopHeadlines(topic: String, completionHandler: @escaping (Data?, Error?)->()){
        var baseURL = "https://newsapi.org/v2/"
        if topic == "top-headlines"{
            baseURL.append(contentsOf: "top-headlines")
        }
        else{
            baseURL.append(contentsOf: "everything")
        }
        
        guard let searchUrl = searchUrl(baseURL: baseURL,for: topic) else{ return }
        print("Search url:",searchUrl)
        let dataTask = URLSession.shared.dataTask(with: searchUrl) { (data, res, err) in

            completionHandler(data, err)
        }
        dataTask.resume()
    }
}
