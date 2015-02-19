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
    var numAlbums = 0
    var numPhotos = 0
    
    private var albumIDs = [String]()
    private var photoDict = [String : [String]]()
    
    let userId: String
    
    private lazy var albumListUrl: String = "https://picasaweb.google.com/data/feed/api/user/\(self.userId)"
    
    private func albumUrl(albumId: String) -> String {
        return "https://picasaweb.google.com/data/feed/api/user/\(userId)/albumid/\(albumId)?imgmax=\(maxImageSize)"
    }
    
    init?(userId: String) {
        self.userId = userId
        var albumInfo = dataForUrl(albumListUrl, xpath: albumInfoPath)
        
        for var i = 0; i < albumInfo.count; i += 2 {
            var numPhotosInAlbum = albumInfo[i+1].toInt()!
            for k in 0..<numPhotosInAlbum {
                albumIDs.append(albumInfo[i])
            }
            numPhotos += numPhotosInAlbum
            ++numAlbums
        }
    }
    
    private func photosInAlbum(albumId: String) -> [String] {
        var photoPaths = dataForUrl(albumUrl(albumId), xpath: photoUrlPath)
        return photoPaths
    }
    
    func randomPhoto() -> NSImage {
        // TODO: better randomizer
        var randomAlbum = albumIDs.randomItem()
        var photoUrls = photosInAlbum(randomAlbum)
        
        var randomPhotoUrl = photoUrls.randomItem()
        
        return NSImage(contentsOfURL: NSURL(string: randomPhotoUrl)!)!
    }
    
// MARK: XML
    func dataForUrl(url: String, xpath: String) -> [String]{
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
