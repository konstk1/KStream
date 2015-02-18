//
//  GooglePlus.swift
//  KStream
//
//  Created by Konstantin Klitenik on 2/16/15.
//  Copyright (c) 2015 Kon. All rights reserved.
//

import AppKit

let albumIdPath = "//entry//gphoto:id"
let photoUrlPath = "//entry/content/@src"
let maxImageSize = "d"      // actual file (other options sXXXX)

class GooglePlus {
    private var numAlbums = 0
    private var numPhotos = 0
    
    private var albums: [String]!
    private var photoDict = [String : [String]]()
    
    let userId: String
    
    lazy var albumListUrl: String = "https://picasaweb.google.com/data/feed/api/user/\(self.userId)?imgmax=d"
    
    func albumUrl(albumId: String) -> String {
        return "https://picasaweb.google.com/data/feed/api/user/\(userId)/albumid/\(albumId)"
    }
    
    init?(userId: String) {
        self.userId = userId
        albums = idsForUrl(albumListUrl, xpath: albumIdPath)
    }
    
    func photosInAlbum(albumId: String) -> [String] {
        // TODO: get full size version (add /d/ before filename in url)
        var photoPaths = idsForUrl(albumUrl(albumId), xpath: photoUrlPath)
        
        return photoPaths
    }
    
    func randomPhoto() -> NSImage {
        // TODO: better randomizer
        var randomAlbum = albums.randomItem()
        var photoUrls = photosInAlbum(randomAlbum)
        
        var randomPhotoUrl = photoUrls.randomItem()
        
        var fileName = randomPhotoUrl.lastPathComponent
        randomPhotoUrl.replaceRange(randomPhotoUrl.rangeOfString(fileName, options: NSStringCompareOptions.allZeros, range: nil, locale: nil)!, with: "\(maxImageSize)/\(fileName)")
        
        println("Path: \(randomPhotoUrl)")
        
        return NSImage(contentsOfURL: NSURL(string: randomPhotoUrl)!)!
    }
    
// MARK: XML
    func idsForUrl(url: String, xpath: String) -> [String]{
        var xmlDoc = NSXMLDocument(contentsOfURL: NSURL(string: url)!, options: Int(NSXMLDocumentContentKind.XMLKind.rawValue), error: nil)
        var nodes = xmlDoc?.nodesForXPath(xpath, error: nil) as! [NSXMLNode]
        
        return nodes.map { $0.objectValue! as! String }
    }
}

extension Array {
    func randomItem() -> T {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
