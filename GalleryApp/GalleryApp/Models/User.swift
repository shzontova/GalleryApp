//
//  User.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 1.02.24.
//

import ObjectMapper

struct User {
    var name = ""
}

extension User: Mappable {
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
    }
}
