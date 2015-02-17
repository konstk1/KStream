//
//  KStreamView.swift
//  KStream
//
//  Created by Konstantin Klitenik on 2/16/15.
//  Copyright (c) 2015 Kon. All rights reserved.
//

import AppKit
import ScreenSaver

class KStreamView : ScreenSaverView {
    
    var imageView: NSImageView!
    var gplus = GooglePlus()
    
    convenience override init() {
        self.init(frame: CGRectZero, isPreview: false)
    }
    
    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        self.setAnimationTimeInterval(1/1.0)
        
        imageView = NSImageView(frame: frame)
        addSubview(imageView)
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func startAnimation() {
        super.startAnimation()
    }
    
    override func stopAnimation() {
        super.stopAnimation()
    }
    
    override func drawRect(rect: NSRect) {
        //super.drawRect(rect)
    }
    
    
    override func animateOneFrame() {
        imageView.frame.size = frame.size
        imageView.image = NSImage(contentsOfURL: NSURL(string: "https://lh4.googleusercontent.com/-blSBoRoapsM/VOEH5mkY_EI/AAAAAAAAFQ4/3t9DefYpzpk/w1768-h1176-no/DSC_5504.JPG")!)
    }
    
    override func hasConfigureSheet() -> Bool {
        return false
    }
    
    override func configureSheet() -> NSWindow! {
        return nil
    }
}
