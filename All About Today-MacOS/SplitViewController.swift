//
//  SplitViewController.swift
//  All About Today-MacOS
//
//  Created by Kushal Mukherjee on 24/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        splitView.delegate = self
        
        self.splitView.setPosition((3/4)*self.splitView.frame.midX, ofDividerAt: 0)
        
        
    }
    override func splitView(_ splitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {
        return NSZeroRect
    }
    
    
    
}
