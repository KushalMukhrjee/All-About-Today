//
//  NewsDetailViewController.swift
//  All About Today-MacOS
//
//  Created by Kushal Mukherjee on 24/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import Cocoa

class NewsDetailViewController: NSViewController {

    @IBOutlet weak var articleImageView: NSImageView!
    
    @IBOutlet weak var articeDescription: NSTextField!
    
    @IBOutlet weak var findOutMoreButton: NSButton!
    @IBOutlet weak var urlLinkLabel: NSTextField!
    
    var article: NewsData.NewsModel? {
        didSet{
            configureUIElements()
        }
    }
    
    
    fileprivate func configureUIElements() {
        if let description = self.article?.description{
            articeDescription.stringValue = description
            articeDescription.font = NSFont(name: "HelveticaNeue-Light", size: 18)
        }
        else{
            articeDescription.stringValue = "No description available. Checkout the link to read the story."
            articeDescription.font = NSFont(name: "HelveticaNeue-Light", size: 18)
        }
        
        if let imgUrlString = self.article?.urlToImage {
            if let imgURL = URL(string: imgUrlString){
                articleImageView.downloadImage(from: imgURL)
            }
            
        }
        else{
            articleImageView.image = NSImage(named: "LoadingImage")
        }
        articleImageView.isHidden = false
        
        urlLinkLabel.stringValue = self.article!.url
        findOutMoreButton.isHidden = false
    }
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        findOutMoreButton.isHidden = true
        articleImageView.isHidden = true
    }
    
    
    @IBAction func findOutMoreClicked(_ sender: NSButton) {
        
        NSWorkspace.shared.open(URL(string: urlLinkLabel.stringValue)!)
               
    }
    
    
}
