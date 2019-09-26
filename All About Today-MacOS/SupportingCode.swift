//
//  SupportingCode.swift
//  All About Today-MacOS
//
//  Created by Kushal Mukherjee on 24/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import Foundation
import AppKit

extension NSImageView{
    
    
    func downloadImage(from imgURL:URL){
        do{
            let imgData = try Data(contentsOf: imgURL)
            OperationQueue.main.addOperation {
                self.image = NSImage(data: imgData)
            }
        }
        catch{
            print("error downloading image:",error.localizedDescription)
        }
        
    }
    
    
    
    
    
}
