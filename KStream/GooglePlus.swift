//
//  GooglePlus.swift
//  KStream
//
//  Created by Konstantin Klitenik on 2/16/15.
//  Copyright (c) 2015 Kon. All rights reserved.
//

import AppKit

let albumInfoPath = "/feed/entry/gphoto:id | /feed/entry/gphoto:numphotos"
let photoUrlPath = "//entry/content/@src"
let maxImageSize = "d"      // actual file (d) (other options sXXXX)

class GooglePlus {
    private var numAlbums = 0
    private var numPhotos = 0
    
    private var albums: [String]!
    private var photoDict = [String : [String]]()
    
    let userId: String
    
    lazy var albumListUrl: String = "https://picasaweb.google.com/data/feed/api/user/\(self.userId)"
    
    func albumUrl(albumId: String) -> String {
        return "https://picasaweb.google.com/data/feed/api/user/\(userId)/albumid/\(albumId)?imgmax=\(maxImageSize)"
    }
    
    init?(userId: String) {
        self.userId = userId
        albums = idsForUrl(albumListUrl, xpath: albumInfoPath)
        // TODO: parse album IDs and photo counts (to be used for random)
        pragma
        print(albums)
    }
    
    func photosInAlbum(albumId: String) -> [String] {
        var photoPaths = idsForUrl(albumUrl(albumId), xpath: photoUrlPath)
        return photoPaths
    }
    
    func randomPhoto() -> NSImage {
        // TODO: better randomizer
        var randomAlbum = albums.randomItem()
        var photoUrls = photosInAlbum(randomAlbum)
        
        var randomPhotoUrl = photoUrls.randomItem()
                
//        println("Path: \(randomPhotoUrl)")
        
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
