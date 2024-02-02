//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 29.01.24.
//

import RxSwift
import RxCocoa
import UIKit

final class GalleryViewController: UIViewController {
    
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let viewModel = GalleryViewModel()
    private let bag = DisposeBag()
    
    private var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
}

// MARK: Setup
private extension GalleryViewController {
    
    func setup() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(R.nib.galleryCollectionViewCell)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 5, left: 10, bottom: 5, right: 10)
        photoCollectionView.collectionViewLayout = layout
    }
}

// MARK: Binding
private extension GalleryViewController {
    
    func bind() {
        viewModel.photos
            .drive(onNext: { [unowned self] images in
                photos = images
                updateCoolectionView()
            })
            .disposed(by: bag)
        
        photoCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let selectedPhoto = self.photos[indexPath.item]
                self.navigateToDetails(with: selectedPhoto)
            })
            .disposed(by: bag)
    }
}

// MARK: Private
private extension GalleryViewController {
    
    func updateCoolectionView() {
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
    
    func navigateToDetails(with image: Photo) {
        let detailsViewController = DetailsViewController()
        detailsViewController.modalPresentationStyle = .fullScreen
        detailsViewController.modalTransitionStyle = .crossDissolve
        present(detailsViewController, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate { }

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { photos.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.galleryCollectionViewCell, for: indexPath) else { return UICollectionViewCell()}
        cell.configure(photo: photos[indexPath.item])
        return cell
    }
}

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.galleryCollectionViewCell, for: indexPath) != nil {
            let width = (view.bounds.width - 30) / 2
            let height = view.bounds.width / 3
            return CGSize(width: width, height: height)
        }
        
        return .zero
    }
}
