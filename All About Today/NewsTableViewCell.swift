//
//  NewsTableViewCell.swift
//  All About Today
//
//  Created by Kushal Mukherjee on 22/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var articleImageView: UIImageView!
    var articleHeading: UILabel!
    
    var article: NewsData.NewsModel? {
        
        didSet{
            articleHeading.text = self.article?.title
            
            let operationQueue = OperationQueue()
            operationQueue.addOperation {
                
                if let imgString = self.article?.urlToImage{
                    
                    let imgURL = URL(string: imgString)!
                    self.articleImageView.downloadImage(from: imgURL)
                   
                }
            }
            
        }
        
    }
    
    fileprivate func configureAccessibility(){
        articleImageView.isAccessibilityElement = true
        articleHeading.isAccessibilityElement = true
        articleImageView.accessibilityTraits = .image
        articleImageView.accessibilityLabel = "Image of the article"
        articleImageView.accessibilityValue = "Image for \(article?.title)"
        
        articleHeading.accessibilityTraits = .none
        articleHeading.accessibilityLabel = "Heading for the article"
        articleHeading.accessibilityValue = article?.title
        
        
    }
    
    
    
    fileprivate func configureViewElements() {
        
        articleHeading.numberOfLines = 0
        articleHeading.backgroundColor = .black
        articleHeading.alpha = 0.8
        articleHeading.textColor = .white
        articleHeading.layer.cornerRadius = 5
        articleHeading.clipsToBounds = true
        articleHeading.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        articleImageView.pinToEdges(of: self)
        articleHeading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        articleHeading.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        articleHeading.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        articleImageView.contentMode = .scaleAspectFill
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        articleHeading = UILabel()
        articleImageView = UIImageView(image: UIImage(named: "LoadingImage"))
        
        self.addSubview(articleImageView)
        self.addSubview(articleHeading)
        
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleHeading.translatesAutoresizingMaskIntoConstraints = false
        
        configureViewElements()
        configureAccessibility()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
