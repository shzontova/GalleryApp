//
//  GalleryAPI.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 30.01.24.
//

import Moya
import ObjectMapper

enum GalleryAPI {
    case getPhotoList(page: Int)
}

extension GalleryAPI: TargetType {
    
    var baseURL: URL { Credentials.url }
    
    var path: String {
        switch self {
        case .getPhotoList:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotoList:
            return .get
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .getPhotoList(let page):
                    return .requestParameters(parameters: ["page": page, "per_page": 30], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        ["Authorization": "Client-ID \(Credentials.accessKey)"]
    }
}
