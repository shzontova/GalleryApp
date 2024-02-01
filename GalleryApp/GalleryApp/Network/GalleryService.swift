//
//  GalleryService.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 30.01.24.
//

import Moya
import ObjectMapper
import RxSwift

final class GalleryService {
    
    static let shared = GalleryService()
    private let provider = MoyaProvider<GalleryAPI>()

    private init() {}

    func getPhotoList(page: Int) -> Single<[Photo]> {
        provider.rx.request(.getPhotoList(page: page))
            .map { response in
                guard let json = try? response.mapJSON() as? [[String: Any]] else {
                    throw MoyaError.jsonMapping(response)
                }
                return Mapper<Photo>().mapArray(JSONArray: json) 
            }
       }
}
