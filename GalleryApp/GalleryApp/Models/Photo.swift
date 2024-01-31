//
//  Photo.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 30.01.24.
//

import ObjectMapper

struct Photo {
    var id: String = ""
    var description: String = ""
    var urls: PhotoURLs?
}

extension Photo: Mappable {
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        urls <- map["urls"]
    }
}
