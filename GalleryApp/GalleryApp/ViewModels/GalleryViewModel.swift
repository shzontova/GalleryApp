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
    private let photoRelay = BehaviorRelay<[Photo]>(value: [])

    let photos: Driver<[Photo]>
    private var page = 1

    init() {
        photos = photoRelay.asDriver()

        photoSubject
            .flatMapLatest { [unowned self] _ in
                service.getPhotoList(page: page)
                    .filter { !$0.isEmpty }
                    .map { result -> [Photo] in
                        self.page += 1
                        return result
                    }
            }
            .bind(to: photoRelay)
            .disposed(by: bag)

        loadPhotos()
    }

    func loadPhotos() {
        photoSubject.onNext(())
    }
}
