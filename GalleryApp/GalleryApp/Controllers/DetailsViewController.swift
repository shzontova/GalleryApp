//
//  DetailsViewController.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 1.02.24.
//

import Kingfisher
import RxSwift
import RxCocoa
import UIKit

final class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var detailsView: GradientView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    
    private let viewModel = DetailsViewModel()
    private let bag = DisposeBag()
    
    private var photoIndex: Int = 0
    private var photos: [Photo] = []
    
    func configure(photos: [Photo], photoIndex: Int) {
        self.photos = photos
        self.photoIndex = photoIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
}

// MARK: Setup
private extension DetailsViewController {
    
    func setup() {
        guard photoIndex < photos.count else { return }
        
        viewModel.setPhoto(photos[photoIndex])
        nameLabel.text = photos[photoIndex].user?.name
        descriptionLabel.text = photos[photoIndex].description
        imageView.loadImage(urlString: photos[photoIndex].urls?.url ?? "")
        setupFavoriteButton()
        setupRecognizers()
    }

    func setupFavoriteButton() {
        let isFavorite = DatabaseManager.isFavorite(photo: photos[photoIndex])
        let buttonImage = isFavorite ? R.image.likeButton() : R.image.unlikeButton()
        favoriteButton.setImage(buttonImage, for: .normal)
    }
    
    func setupRecognizers() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)

        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(backToGallery))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
}

// MARK: Binding
private extension DetailsViewController {
    
    func bind() {
        backButton.rx.tap.asDriver().drive(onNext: { [unowned self]_ in
            dismiss(animated: true)
        }).disposed(by: bag)
        
        viewModel.isFavoriteRelay
            .bind(onNext: { [unowned self] isFavorite in
                let buttonImage = isFavorite ? R.image.likeButton() : R.image.unlikeButton()
                favoriteButton.setImage(buttonImage, for: .normal)
            })
            .disposed(by: bag)

        favoriteButton.rx.tap.asDriver()
            .drive(viewModel.favoriteSubject)
            .disposed(by: bag)
    }
}

// MARK: Private
private extension DetailsViewController {
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            photoIndex = min(photoIndex + 1, photos.count - 1)
        case .down:
            photoIndex = max(photoIndex - 1, 0)
        default:
            return
        }
        
        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: [.transitionCrossDissolve],
                          animations: { [weak self] in self?.updateUI() },
                          completion: nil)
    }
    
    @objc func backToGallery() {
        dismiss(animated: true)
    }
    
    func updateUI() {
        guard photoIndex < photos.count else { return }
        
        viewModel.setPhoto(photos[photoIndex])
        nameLabel.text = photos[photoIndex].user?.name
        descriptionLabel.text = photos[photoIndex].description
        imageView.loadImage(urlString: photos[photoIndex].urls?.url ?? "")
        setupFavoriteButton()
    }
}
