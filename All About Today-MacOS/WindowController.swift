//
//  WindowController.swift
//  All About Today-MacOS
//
//  Created by Kushal Mukherjee on 24/09/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import Cocoa


class WindowController: NSWindowController, NSWindowDelegate{
    
    override func windowDidLoad() {
        window?.delegate = self
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApp.hide(self)
        return false
    }
    


}

