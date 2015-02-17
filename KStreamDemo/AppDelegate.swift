//
//  AppDelegate.swift
//  KStreamDemo
//
//  Created by Konstantin Klitenik on 2/16/15.
//  Copyright (c) 2015 Kon. All rights reserved.
//

import Cocoa
import ScreenSaver

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    let screenSaver: ScreenSaverView = {
        let view = KStreamView()
        view.autoresizingMask = NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable
        return view
        }()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Add the clock view to the window
        screenSaver.frame = window.contentView.bounds
        window.contentView.addSubview(screenSaver)
        
        // Start animating the clock
        screenSaver.startAnimation()
        NSTimer.scheduledTimerWithTimeInterval(screenSaver.animationTimeInterval(), target: screenSaver, selector: "animateOneFrame", userInfo: nil, repeats: true)
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func windowWillClose(notification: NSNotification) {
        // Quit the app if the main window is closed
        NSApplication.sharedApplication().terminate(window)
    }
    
}

