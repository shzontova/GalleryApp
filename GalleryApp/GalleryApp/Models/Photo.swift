//
//  Photo.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 30.01.24.
//

import ObjectMapper

struct Photo {
    var id = ""
    var description = ""
    var urls: PhotoURLs?
    var user: User?
}

extension Photo: Mappable {
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        urls <- map["urls"]
        user <- map["user"]
    }
}
