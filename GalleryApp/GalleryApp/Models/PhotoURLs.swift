//
//  PhotoURLs.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 30.01.24.
//

import ObjectMapper

struct PhotoURLs {
    var url: URL?
}

extension PhotoURLs: Mappable {
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        url <- map["regular"]
    }
}
