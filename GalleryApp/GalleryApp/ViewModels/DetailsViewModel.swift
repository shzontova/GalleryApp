//
//  DetailsViewModel.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 1.02.24.
//

import RxSwift
import RxCocoa

final class DetailsViewModel {
    
    private var photo: Photo?
    private let bag = DisposeBag()
    
    let favoriteSubject: PublishSubject<Void> = PublishSubject()
    let isFavoriteRelay = PublishRelay<Bool>()
    
    init() {
        
        bind()
    }

    func setPhoto(_ photo: Photo) {
        self.photo = photo
        isFavoriteRelay.accept(DatabaseManager.isFavorite(photo: photo))
    }
    
    private func bind() {
        favoriteSubject
            .subscribe(onNext: { [unowned self] in isSavedPhoto() })
            .disposed(by: bag)
    }
}

// MARK: Private
private extension DetailsViewModel {
    
    func isSavedPhoto() {
        if let photo {
            let isFavorite = !DatabaseManager.isFavorite(photo: photo)
            DatabaseManager.toggleFavorite(photo: photo)
            isFavoriteRelay.accept(isFavorite)
        }
    }
}
