//
//  NewsDetailViewController.swift
//  All About Today
//
//  Created by Kushal Mukherjee on 23/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import UIKit
import SafariServices

class NewsDetailViewController: UIViewController {
   
    var articleImageView: UIImageView!
    var articleDescription: UILabel!
    var articleUrl: UIButton!
    
    var article: NewsData.NewsModel?
   
    fileprivate func configureViewElements() {
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        articleUrl.translatesAutoresizingMaskIntoConstraints = false
        
        articleImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 0).isActive = true
        articleImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 0).isActive = true
        articleImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.view.trailingAnchor, multiplier: 0).isActive = true
        articleImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        articleImageView.layer.cornerRadius = 20
        articleImageView.clipsToBounds = true
        
        
        
        articleDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        articleDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        articleDescription.topAnchor.constraint(equalTo: self.articleImageView.bottomAnchor, constant: 20).isActive = true
        articleDescription.numberOfLines = 0
        articleDescription.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        
        articleUrl.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        articleUrl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        articleUrl.topAnchor.constraint(equalTo: self.articleDescription.bottomAnchor, constant: 30).isActive = true
        
        articleUrl.contentHorizontalAlignment = .left
        articleUrl.addTarget(self, action: #selector(articleUrlClicked(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        articleImageView = UIImageView()
        articleDescription = UILabel()
        articleUrl = UIButton(type: .system)
        
        
        self.view.addSubview(articleImageView)
        self.view.addSubview(articleDescription)
        self.view.addSubview(articleUrl)
        
        configureViewElements()
        configureAccessibility()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = self.article?.description{
            articleDescription.text = self.article?.description
        }
        else{
            articleDescription.text = "No description available. Click the link below for full story."
        }
        articleUrl.titleLabel?.numberOfLines = 0
        articleUrl.setTitle("\(self.article!.url)", for: .normal)
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            if let imgString = self.article?.urlToImage{
                 let imgURL = URL(string: imgString)!
                 self.articleImageView.downloadImage(from: imgURL)
              }
            else{
                OperationQueue.main.addOperation {
                    self.articleImageView.image = UIImage(named: "LoadingImage")
                }
                
            }
        }
    }
    
    @objc func articleUrlClicked(sender:UIButton){
        
        guard let urlString = sender.titleLabel?.text else {return}
        
        guard let openUrl = URL(string: urlString) else {return}
        
        let safariViewController = SFSafariViewController(url: openUrl)
        present(safariViewController, animated: true, completion: nil)
        
    }
    
    fileprivate func configureAccessibility(){
        
        articleImageView.isAccessibilityElement = true
        articleDescription.isAccessibilityElement = true
        articleUrl.isAccessibilityElement = true
        
        articleImageView.accessibilityLabel = "Image for Article"
        articleImageView.accessibilityValue = "Image of \(article?.title)"
        articleImageView.accessibilityTraits = .image
        
        articleDescription.accessibilityLabel = "Article description"
        articleDescription.accessibilityValue = article?.description
        
        articleUrl.accessibilityLabel = "Url for the full story"
        articleUrl.accessibilityHint = "Click to go to the full story"
        articleUrl.accessibilityTraits = .link
    }
}
