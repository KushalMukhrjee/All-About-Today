//
//  SupportingCode.swift
//  All About Today-MacOS
//
//  Created by Kushal Mukherjee on 23/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    
    func pinToEdges(of superView: UIView){
        
        self.topAnchor.constraint(equalToSystemSpacingBelow: superView.topAnchor, multiplier: 0).isActive = true
        self.bottomAnchor.constraint(equalToSystemSpacingBelow: superView.bottomAnchor, multiplier: 0).isActive = true
        self.leadingAnchor.constraint(equalToSystemSpacingAfter: superView.leadingAnchor, multiplier: 0).isActive = true
        self.trailingAnchor.constraint(equalToSystemSpacingAfter: superView.trailingAnchor, multiplier: 0).isActive = true
        
        
    }
    
}

extension UIImageView{
    
    func downloadImage(from imgURL:URL){
        do{
            let imgData = try Data(contentsOf: imgURL)
            OperationQueue.main.addOperation {
                self.image = UIImage(data: imgData)
            }
        }
        catch{
            print("error downloading image:",error.localizedDescription)
        }
        
    }
    
}
