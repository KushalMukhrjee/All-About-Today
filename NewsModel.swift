//
//  NewsModel.swift
//  All About Today
//
//  Created by Kushal Mukherjee on 22/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import Foundation

struct NewsData: Codable {
    
    struct NewsModel: Codable{
        
        var title: String
        var description: String?
        var url: String
        var urlToImage: String?
        
    }
    var articles: [NewsModel]
}


