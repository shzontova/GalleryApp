//
//  GalleryViewModel.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 30.01.24.
//

import RxSwift
import RxCocoa

final class GalleryViewModel {
    
    private let bag = DisposeBag()
    private let service = GalleryService.shared
    private let photoSubject = PublishSubject<Void>()
    private var page = 1
    
    let photoRelay = BehaviorRelay<[Photo]>(value: [])

    init() {
        photoSubject
            .flatMapLatest { [unowned self] _ in
                service.getPhotoList(page: page)
                    .filter { !$0.isEmpty }
            }.subscribe(onNext: { [unowned self] result in
                page += 1
                var photos = photoRelay.value
                photos.append(contentsOf: result)
                photoRelay.accept(photos)
            })
            .disposed(by: bag)

        loadPhotos()
    }

    func loadPhotos() {
        photoSubject.onNext(())
    }
}
