//
//  GooglePlus.swift
//  KStream
//
//  Created by Konstantin Klitenik on 2/16/15.
//  Copyright (c) 2015 Kon. All rights reserved.
//

import Foundation

class GooglePlus : NSObject, NSXMLParserDelegate {
    var tabs = 0
    var entryFound = false
    var albumIdFound = false
    var numAlbums = 0
    
    override init() {
        super.init()
        var url = "https://picasaweb.google.com/data/feed/api/user/104917095337339744256"
        if let parser = NSXMLParser(contentsOfURL: NSURL(string: url)) {
            parser.delegate = self
            parser.parse()
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
//        print("\n")
//        for _ in 0..<tabs {
//            print("\t")
//        }
//        
//        print("< \(elementName) - ")
        tabs++
        
        if elementName == "entry" {
            entryFound = true
        } else if entryFound && elementName == "gphoto:id" {
            albumIdFound = true
        }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        tabs--
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
//        println(string!)
        if albumIdFound {
            println("\(numAlbums): \(string!)")
            entryFound = false
            albumIdFound = false
            ++numAlbums
        }
    }
}
